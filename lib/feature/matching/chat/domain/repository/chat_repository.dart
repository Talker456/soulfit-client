import '../entity/message.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages({required String chatRoomId});

  Future<void> sendMessage({required String chatRoomId, required String text});

  Stream<Message> listenToMessages({required String chatRoomId});
}
