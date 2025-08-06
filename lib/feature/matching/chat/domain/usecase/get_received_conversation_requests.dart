import '../entity/chat_request.dart';
import '../repository/conversation_request_repository.dart';

class GetReceivedConversationRequests {
  final ConversationRequestRepository repository;

  GetReceivedConversationRequests(this.repository);

  Future<List<ChatRequest>> call() {
    return repository.getReceivedConversationRequests();
  }
}
