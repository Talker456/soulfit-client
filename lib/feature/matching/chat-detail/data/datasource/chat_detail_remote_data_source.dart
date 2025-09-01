import 'dart:io';

import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_message_model.dart';

abstract class ChatDetailRemoteDataSource {
  Future<List<ChatMessageModel>> getMessages(String roomId, int page, int size);

  Future<ChatMessageModel> sendImage(String roomId, File image);

  Future<void> leaveChatRoom(String roomId);
}
