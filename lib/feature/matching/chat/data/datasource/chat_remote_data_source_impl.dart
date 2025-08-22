import 'dart:async';

import '../model/message_model.dart';
import 'chat_remote_data_source.dart';

// TODO: Implement with actual API client (e.g., Dio, http) and WebSocket client.
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  @override
  Future<List<MessageModel>> getMessages({required String chatRoomId}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Dummy data
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
    ];
  }

  @override
  Future<void> sendMessage({required String chatRoomId, required String text}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    // In a real implementation, this would send the message to the server.
    print('Message sent to $chatRoomId: $text');
  }

  @override
  Stream<MessageModel> listenToMessages({required String chatRoomId}) {
    // In a real implementation, this would connect to a WebSocket
    // and yield new messages.
    return const Stream.empty();
  }
}
