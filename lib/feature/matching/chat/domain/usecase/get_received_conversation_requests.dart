import '../entity/chat_request.dart';
import '../repository/conversation_request_repository.dart';

class GetReceivedConversationRequests {
  final ConversationRequestRepository repository;

  GetReceivedConversationRequests(this.repository);

  Future<List<ChatRequest>> call() {
    print('[get received conversation_req request usecase] : start getting rvcd conv reqs');
    return repository.getReceivedConversationRequests();
  }
}
