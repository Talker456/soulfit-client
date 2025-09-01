import 'dart:io';

import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_detail_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/web_socket_service.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class ChatDetailRepositoryImpl implements ChatDetailRepository {
  final ChatDetailRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  WebSocketService? _webSocketService;

  ChatDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<List<ChatMessage>> getMessages(String roomId, int page, int size) {
    return remoteDataSource.getMessages(roomId, page, size);
  }

  @override
  Future<ChatMessage> sendImage(String roomId, File image) {
    return remoteDataSource.sendImage(roomId, image);
  }

  @override
  Future<void> leaveChatRoom(String roomId) {
    return remoteDataSource.leaveChatRoom(roomId);
  }

  @override
  Future<void> connectToChat(String roomId, Function(ChatMessage) onMessageReceived) async {
    final token = await authLocalDataSource.getAccessToken();
    if (token == null) {
      throw Exception('Authentication token not found');
    }
    _webSocketService = WebSocketService(onMessageReceived: onMessageReceived);
    _webSocketService!.connect(token, roomId);
  }

  @override
  void sendTextMessage({required String roomId, required String messageText, required String sender}) {
    _webSocketService?.sendMessage(roomId: roomId, messageText: messageText, sender: sender);
  }

  @override
  void disconnectFromChat() {
    _webSocketService?.disconnect();
    _webSocketService = null;
  }
}
