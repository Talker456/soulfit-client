import '../entity/sent_chat_request.dart';
import '../repository/conversation_request_repository.dart';

class GetSentConversationRequests {
  final ConversationRequestRepository repository;

  GetSentConversationRequests(this.repository);

  Future<List<SentChatRequest>> call() {
    return repository.getSentConversationRequests();
  }
}
