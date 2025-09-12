
import 'dart:io';

import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_analysis_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_detail_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_message_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_analysis.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class ChatDetailRepositoryImpl implements ChatDetailRepository {
  final ChatDetailRemoteDataSource remoteDataSource;
  final ChatMessageDataSource messageDataSource;
  final ChatAnalysisDataSource analysisDataSource;

  ChatDetailRepositoryImpl({
    required this.remoteDataSource,
    required this.messageDataSource,
    required this.analysisDataSource,
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
  void sendTextMessage({required String roomId, required String messageText, required String sender}) {
    messageDataSource.sendMessage(roomId: roomId, messageText: messageText, sender: sender);
  }

  @override
  Stream<ChatAnalysis> getAnalysisStream(String roomId) {
    return analysisDataSource.analysisStream;
  }

  @override
  Stream<ChatMessage> getMessageStream(String roomId) {
    return messageDataSource.messageStream;
  }
  
  // connectToChat and disconnectFromChat are now managed by the connection manager and data sources directly
  // so they are removed from the repository interface and implementation.
  @override
  Future<void> connectToChat(String roomId) async {
    // This is now handled by the individual data sources when they are initialized.
  }

  @override
  void disconnectFromChat() {
    // This is handled by the StompConnectionManager's dispose logic, triggered by the provider.
  }
}

