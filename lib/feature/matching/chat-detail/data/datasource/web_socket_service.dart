import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_message_model.dart';

class WebSocketService {
  StompClient? _stompClient;
  final Function(ChatMessageModel) onMessageReceived;
  StreamSubscription<StompFrame>? _subscription;

  WebSocketService({required this.onMessageReceived});

  void connect(String token, String roomId) {
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://$BASE_URL:8080/ws', // WebSocket 엔드포인트
        onConnect: (StompFrame frame) {
          print('WebSocket connected');
          _subscribeToRoom(roomId);
        },
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer $token'},
      ),
    );
    _stompClient!.activate();
  }

  void _subscribeToRoom(String roomId) {
    if (_stompClient == null || !_stompClient!.connected) {
      print('Cannot subscribe, client is not connected');
      return;
    }
    _subscription = _stompClient!.subscribe(
      destination: '/topic/room/$roomId',
      callback: (StompFrame frame) {
        if (frame.body != null) {
          final Map<String, dynamic> data = jsonDecode(frame.body!);
          final message = ChatMessageModel.fromJson(data);
          onMessageReceived(message);
        }
      },
    ) as StreamSubscription<StompFrame>?;
  }

  void sendMessage({required String roomId, required String messageText, required String sender}) {
    if (_stompClient != null && _stompClient!.connected) {
      _stompClient!.send(
        destination: '/app/chat/send',
        body: jsonEncode({
          'roomId': int.tryParse(roomId) ?? 0,
          'sender': sender,
          'message': messageText,
        }),
      );
    }
  }

  void disconnect() {
    _subscription?.cancel();
    _stompClient?.deactivate();
    print('WebSocket disconnected');
  }
}
