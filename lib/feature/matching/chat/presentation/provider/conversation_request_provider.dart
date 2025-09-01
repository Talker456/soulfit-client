import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/matching/chat/data/datasource/conversatoin_request_remote_data_source_impl.dart';

import '../../data/datasource/conversation_request_fake_remote_data_source.dart';
import '../../data/repository_impl/conversation_request_repository_impl.dart';
import '../../domain/usecase/accept_conversation_request.dart';
import '../../domain/usecase/get_received_conversation_requests.dart';
import '../../domain/usecase/get_sent_conversation_requests.dart';
import '../../domain/usecase/reject_conversation_request.dart';
import '../../domain/usecase/send_conversation_request.dart';
import '../notifier/conversation_request_notifier.dart';
import '../notifier/sent_conversation_request_notifier.dart';
import '../state/conversation_request_state.dart';
import '../state/sent_conversation_request_state.dart';


// Repository
final _fakeRemoteDataSourceProvider = Provider((ref){
  if(USE_FAKE_DATASOURCE){
    return FakeConversationRequestRemoteDataSource();
  }else{
    return ConversationRequestRemoteDataSourceImpl(
        client: ref.read(httpClientProvider),
        source: ref.read(authLocalDataSourceProvider),
        base: BASE_URL);
  }
  
});

final _repositoryProvider = Provider((ref) =>
    ConversationRequestRepositoryImpl(ref.watch(_fakeRemoteDataSourceProvider)));

// UseCases
final _getReceivedRequestsProvider = Provider(
        (ref) => GetReceivedConversationRequests(ref.watch(_repositoryProvider)));

final _getSentRequestsProvider = Provider(
        (ref) => GetSentConversationRequests(ref.watch(_repositoryProvider)));

final _acceptRequestProvider = Provider(
        (ref) => AcceptConversationRequest(ref.watch(_repositoryProvider)));

final _rejectRequestProvider = Provider(
        (ref) => RejectConversationRequest(ref.watch(_repositoryProvider)));

final _sendRequestProvider = Provider(
        (ref) => SendConversationRequest(ref.watch(_repositoryProvider)));

// Notifier
final conversationRequestNotifierProvider = StateNotifierProvider<
    ConversationRequestNotifier, ConversationRequestState>((ref) {
  return ConversationRequestNotifier(
    getRequests: ref.watch(_getReceivedRequestsProvider),
    acceptRequest: ref.watch(_acceptRequestProvider),
    rejectRequest: ref.watch(_rejectRequestProvider),
  );
});

final sentConversationRequestNotifierProvider = StateNotifierProvider<
    SentConversationRequestNotifier, SentConversationRequestState>((ref) {
  return SentConversationRequestNotifier(
    getSentRequests: ref.watch(_getSentRequestsProvider),
  );
});
