import 'dart:async';
import '../../domain/entity/message.dart';
import '../../domain/entity/participant.dart';
import '../../domain/entity/room.dart';
import 'chat_remote_datasource.dart';

class ChatRemoteDataSourceMock implements ChatRemoteDataSource {
  final _controllers = <String, StreamController<Message>>{};

  final _rooms = <Room>[
    Room(
      id: 'r1',
      title: '[강남] 분위기 좋은 와인파티',
      isActive: true,
      lastMessagePreview: '안녕하세요!',
      lastMessageAt: DateTime.now().subtract(const Duration(minutes: 1)),
    ),
    Room(
      id: 'r2',
      title: '[수원] 베이킹 같이해요',
      isActive: true,
      lastMessagePreview: '혹시 어떤 스타일...',
      lastMessageAt: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    Room(
      id: 'r3',
      title: '[종료] 지난 주말 번개',
      isActive: false,
      lastMessagePreview: '수고하셨습니다!',
      lastMessageAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  final _messages = <String, List<Message>>{
    'r1': [
      Message(
        id: 'm1',
        roomId: 'r1',
        text: '안녕하세요! 저는 사용자 A입니다.',
        sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
        sender: SenderType.other,
      ),
      Message(
        id: 'm2',
        roomId: 'r1',
        text: '반가워요.',
        sentAt: DateTime.now().subtract(
          const Duration(minutes: 1, seconds: 20),
        ),
        sender: SenderType.other,
      ),
      Message(
        id: 'm3',
        roomId: 'r1',
        text: '안녕하세요!',
        sentAt: DateTime.now().subtract(const Duration(minutes: 1)),
        sender: SenderType.me,
      ),
    ],
    'r2': [],
  };

  @override
  Future<List<Room>> fetchRooms({bool? activeOnly}) async {
    await Future.delayed(const Duration(milliseconds: 250));
    var list = _rooms;
    if (activeOnly != null) {
      list = list.where((r) => r.isActive == activeOnly).toList();
    }
    list.sort(
      (a, b) => (b.lastMessageAt ?? DateTime(0)).compareTo(
        a.lastMessageAt ?? DateTime(0),
      ),
    );
    return list;
  }

  @override
  Future<List<Message>> fetchMessages(String roomId, {int limit = 50}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final list = List<Message>.from(_messages[roomId] ?? []);
    list.sort((a, b) => a.sentAt.compareTo(b.sentAt));
    return list.take(limit).toList();
  }

  @override
  Stream<Message> messageStream(String roomId) {
    return (_controllers[roomId] ??= StreamController<Message>.broadcast())
        .stream;
  }

  @override
  Future<void> send(String roomId, String text) async {
    final msg = Message(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      roomId: roomId,
      text: text,
      sentAt: DateTime.now(),
      sender: SenderType.me,
    );
    _messages.putIfAbsent(roomId, () => []).add(msg);
    _controllers[roomId]?.add(msg);
  }

  @override
  Future<List<Participant>> fetchParticipants(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return const [
      Participant(id: 'u1', nickname: '민지'),
      Participant(id: 'u2', nickname: '현우'),
      Participant(id: 'u3', nickname: '수진'),
    ];
  }

  @override
  Future<void> leave(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    // 목 구현: 아무 것도 안 함
  }
}
