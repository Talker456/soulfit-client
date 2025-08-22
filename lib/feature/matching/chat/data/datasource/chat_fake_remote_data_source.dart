import 'dart:async';

import '../model/message_model.dart';
import 'chat_remote_data_source.dart';

class ChatFakeRemoteDataSource implements ChatRemoteDataSource {
  @override
  Future<List<MessageModel>> getMessages({required String chatRoomId}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy data representing an initial chat history
    return [
      MessageModel(
        id: '1',
        chatRoomId: chatRoomId,
        senderId: 'opponent_id',
        text: '안녕하세요! 대화 걸어주셔서 감사해요.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      MessageModel(
        id: '2',
        chatRoomId: chatRoomId,
        senderId: 'my_id', // Assume 'my_id' is the current user's ID
        text: '네, 안녕하세요! 프로필 보고 관심 생겨서 연락드렸어요.',
        createdAt: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      MessageModel(
        id: '3',
        chatRoomId: chatRoomId,
        senderId: 'opponent_id',
        text: '어떤 점이 마음에 드셨나요? ㅎㅎ',
        createdAt: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
    ];
  }

  @override
  Future<void> sendMessage({required String chatRoomId, required String text}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a fake implementation, we can just print the action
    print('FakeSendMessage: Message sent to $chatRoomId: $text');
  }

  @override
  Stream<MessageModel> listenToMessages({required String chatRoomId}) {
    // Simulate receiving a new message every 3 seconds
    return Stream.periodic(const Duration(seconds: 3), (count) {
      return MessageModel(
        id: 'stream_${count + 1}',
        chatRoomId: chatRoomId,
        senderId: 'opponent_id',
        text: '이건 실시간으로 받은 메시지입니다. ${count + 1}',
        createdAt: DateTime.now(),
      );
    }).take(5); // Limit to 5 messages for demonstration
  }
}
