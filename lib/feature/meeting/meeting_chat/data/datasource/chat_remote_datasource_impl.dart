import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../../domain/entity/message.dart';
import '../../domain/entity/participant.dart';
import '../../domain/entity/room.dart';
import 'chat_remote_datasource.dart';

/// 실제 백엔드 API와 WebSocket 통신을 담당하는 DataSource 구현
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  // WebSocket 연결 관리
  final Map<String, WebSocketChannel> _wsConnections = {};
  final Map<String, StreamController<Message>> _messageControllers = {};

  ChatRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  /// 채팅방 목록 조회
  @override
  Future<List<Room>> fetchRooms({bool? activeOnly}) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - GET /api/meetings/chat/rooms
      // - GET /api/chat/rooms
      // - GET /api/meetings/rooms
      final queryParams = activeOnly != null ? '?active=$activeOnly' : '';
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/meetings/chat/rooms$queryParams'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(responseBody);

        if (jsonData is List) {
          return jsonData.map((json) => _roomFromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('채팅방 목록 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('채팅방 목록 요청 실패: $e');
    }
  }

  /// 과거 메시지 조회
  @override
  Future<List<Message>> fetchMessages(String roomId, {int limit = 50}) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - GET /api/meetings/chat/rooms/{roomId}/messages
      // - GET /api/chat/rooms/{roomId}/messages
      final response = await client.get(
        Uri.parse(
          'http://$baseUrl:8080/api/meetings/chat/rooms/$roomId/messages?limit=$limit',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(responseBody);

        if (jsonData is List) {
          return jsonData.map((json) => _messageFromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('메시지 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('메시지 조회 요청 실패: $e');
    }
  }

  /// 실시간 메시지 스트림 (WebSocket)
  @override
  Stream<Message> messageStream(String roomId) {
    // 이미 연결된 스트림이 있으면 반환
    if (_messageControllers.containsKey(roomId)) {
      return _messageControllers[roomId]!.stream;
    }

    // 새 스트림 컨트롤러 생성
    final controller = StreamController<Message>.broadcast(
      onCancel: () => _disconnectWebSocket(roomId),
    );
    _messageControllers[roomId] = controller;

    // WebSocket 연결 시작
    _connectWebSocket(roomId);

    return controller.stream;
  }

  /// WebSocket 연결
  Future<void> _connectWebSocket(String roomId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 WebSocket 엔드포인트 확인 필요
      // 예상 엔드포인트:
      // - ws://localhost:8080/ws/chat/{roomId}
      // - ws://localhost:8080/api/chat/rooms/{roomId}/ws
      //
      // WebSocket 인증 방법도 확인 필요:
      // - URL 쿼리 파라미터: ?token=xxx
      // - 첫 메시지로 인증 정보 전송
      // - Sec-WebSocket-Protocol 헤더 사용
      final wsUrl = 'ws://$baseUrl:8080/ws/chat/$roomId?token=$token';
      final channel = WebSocketChannel.connect(Uri.parse(wsUrl));

      _wsConnections[roomId] = channel;

      // 메시지 수신 리스닝
      channel.stream.listen(
        (data) {
          try {
            final json = jsonDecode(data);
            final message = _messageFromJson(json);
            _messageControllers[roomId]?.add(message);
          } catch (e) {
            print('메시지 파싱 실패: $e');
          }
        },
        onError: (error) {
          print('WebSocket 에러: $error');
          _messageControllers[roomId]?.addError(error);
        },
        onDone: () {
          print('WebSocket 연결 종료: $roomId');
          _disconnectWebSocket(roomId);
        },
      );
    } catch (e) {
      print('WebSocket 연결 실패: $e');
      _messageControllers[roomId]?.addError(e);
    }
  }

  /// WebSocket 연결 해제
  void _disconnectWebSocket(String roomId) {
    _wsConnections[roomId]?.sink.close();
    _wsConnections.remove(roomId);
    _messageControllers[roomId]?.close();
    _messageControllers.remove(roomId);
  }

  /// 메시지 전송
  @override
  Future<void> send(String roomId, String text) async {
    try {
      // WebSocket으로 전송
      final wsChannel = _wsConnections[roomId];
      if (wsChannel != null) {
        final messageData = jsonEncode({
          'type': 'message',
          'roomId': roomId,
          'text': text,
          'timestamp': DateTime.now().toIso8601String(),
        });
        wsChannel.sink.add(messageData);
      } else {
        // WebSocket 연결이 없으면 REST API로 전송
        // TODO: 백엔드 API 명세 확인 필요
        final token = await authSource.getAccessToken();
        if (token == null) {
          throw Exception('인증 토큰이 없습니다.');
        }

        final response = await client.post(
          Uri.parse(
            'http://$baseUrl:8080/api/meetings/chat/rooms/$roomId/messages',
          ),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({
            'text': text,
            'timestamp': DateTime.now().toIso8601String(),
          }),
        );

        if (response.statusCode != 200 && response.statusCode != 201) {
          throw Exception('메시지 전송 실패: ${response.statusCode}');
        }
      }
    } catch (e) {
      throw Exception('메시지 전송 실패: $e');
    }
  }

  /// 참가자 목록 조회
  @override
  Future<List<Participant>> fetchParticipants(String roomId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - GET /api/meetings/chat/rooms/{roomId}/participants
      // - GET /api/chat/rooms/{roomId}/members
      final response = await client.get(
        Uri.parse(
          'http://$baseUrl:8080/api/meetings/chat/rooms/$roomId/participants',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(responseBody);

        if (jsonData is List) {
          return jsonData.map((json) => _participantFromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('참가자 목록 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('참가자 목록 요청 실패: $e');
    }
  }

  /// 채팅방 나가기
  @override
  Future<void> leave(String roomId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // WebSocket 연결 먼저 해제
      _disconnectWebSocket(roomId);

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - DELETE /api/meetings/chat/rooms/{roomId}/participants/me
      // - POST /api/meetings/chat/rooms/{roomId}/leave
      final response = await client.delete(
        Uri.parse(
          'http://$baseUrl:8080/api/meetings/chat/rooms/$roomId/participants/me',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('채팅방 나가기 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('채팅방 나가기 요청 실패: $e');
    }
  }

  /// JSON → Room Entity 변환
  Room _roomFromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식에 맞춰 수정 필요
    return Room(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      isActive: json['isActive'] ?? json['active'] ?? true,
      lastMessagePreview: json['lastMessagePreview'] ?? json['lastMessage'],
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.tryParse(json['lastMessageAt'])
          : null,
    );
  }

  /// JSON → Message Entity 변환
  Message _messageFromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식에 맞춰 수정 필요
    // 특히 sender 구분 로직 확인 필요 (본인 vs 타인)
    return Message(
      id: json['id']?.toString() ?? '',
      roomId: json['roomId']?.toString() ?? '',
      text: json['text'] ?? json['content'] ?? '',
      sentAt: json['sentAt'] != null
          ? DateTime.parse(json['sentAt'])
          : DateTime.now(),
      sender: json['isMine'] == true ? SenderType.me : SenderType.other,
    );
  }

  /// JSON → Participant Entity 변환
  Participant _participantFromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식에 맞춰 수정 필요
    return Participant(
      id: json['id']?.toString() ?? json['userId']?.toString() ?? '',
      nickname: json['nickname'] ?? json['username'] ?? '',
    );
  }

  /// 리소스 정리
  void dispose() {
    for (var roomId in _wsConnections.keys.toList()) {
      _disconnectWebSocket(roomId);
    }
  }
}
