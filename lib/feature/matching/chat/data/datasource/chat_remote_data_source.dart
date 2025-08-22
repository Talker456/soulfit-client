import '../model/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<MessageModel>> getMessages({required String chatRoomId});

  Future<void> sendMessage({required String chatRoomId, required String text});

  Stream<MessageModel> listenToMessages({required String chatRoomId});
}
