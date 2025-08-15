
import 'package:soulfit_client/feature/matching/chat/domain/entity/sent_chat_request.dart';

import '../../../../matching/chat/domain/entity/chat_request.dart';
import '../../../../matching/chat/domain/repository/conversation_request_repository.dart';
import '../datasource/conversation_request_remote_data_source.dart';

class ConversationRequestRepositoryImpl
    implements ConversationRequestRepository {
  final ConversationRequestRemoteDataSource remoteDataSource;

  ConversationRequestRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> acceptConversationRequest(int requestId) {
    return remoteDataSource.acceptRequest(requestId);
  }

  @override
  Future<List<ChatRequest>> getReceivedConversationRequests() async {
    print('[conversation request repository impl] : get rcvd conv reqs');
    final models = await remoteDataSource.getReceivedRequests();
    return models;
  }

  @override
  Future<List<SentChatRequest>> getSentConversationRequests() async {
    final models = await remoteDataSource.getSentRequests();
    return models;
  }

  @override
  Future<void> rejectConversationRequest(int requestId) {
    return remoteDataSource.rejectRequest(requestId);
  }

  @override
  Future<SentChatRequest> sendConversationRequest(
      {required int toUserId, required String message}) {
    return remoteDataSource.sendRequest(toUserId: toUserId, message: message);
  }
}

