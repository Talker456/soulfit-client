import 'dart:io';

import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';

abstract class ChatDetailRepository {
  // HTTP 기반 기능
  Future<List<ChatMessage>> getMessages(String roomId, int page, int size);
  Future<ChatMessage> sendImage(String roomId, File image);
  Future<void> leaveChatRoom(String roomId);

  // WebSocket 기반 기능
  Future<void> connectToChat(String roomId, Function(ChatMessage) onMessageReceived);
  void sendTextMessage({required String roomId, required String messageText, required String sender});
  void disconnectFromChat();
}
