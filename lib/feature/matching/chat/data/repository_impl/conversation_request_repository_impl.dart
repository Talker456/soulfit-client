
import 'package:soulfit_client/feature/matching/chat/domain/entity/chat_room.dart';
import 'package:soulfit_client/feature/matching/chat/domain/entity/sent_chat_request.dart';

import '../../../../matching/chat/domain/entity/chat_request.dart';
import '../../../../matching/chat/domain/repository/conversation_request_repository.dart';
import '../datasource/conversation_request_remote_data_source.dart';
import 'dart:developer';

class ConversationRequestRepositoryImpl
    implements ConversationRequestRepository {
  final ConversationRequestRemoteDataSource remoteDataSource;

  ConversationRequestRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ChatRequest>> getReceivedConversationRequests() async {
    final models = await remoteDataSource.getReceivedRequests();
    return models;
  }

  @override
  Future<List<SentChatRequest>> getSentConversationRequests() async {
    final models = await remoteDataSource.getSentRequests();
    return models;
  }

  @override
  Future<ChatRoom> acceptConversationRequest(String userId) async{
    log('[RepositoryImpl] acceptConversationRequest called with userId: $userId');
    final result = await remoteDataSource.acceptRequest(userId);
    log('[RepositoryImpl] ChatRoomModel returned: id=${result.id}');
    return result;
  }

  @override
  Future<void> rejectConversationRequest(String userId) {
    return remoteDataSource.rejectRequest(userId);
  }
}

