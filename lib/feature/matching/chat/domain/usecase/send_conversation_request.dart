import '../entity/sent_chat_request.dart';
import '../repository/conversation_request_repository.dart';

class SendConversationRequest {
  final ConversationRequestRepository repository;

  SendConversationRequest(this.repository);

  Future<SentChatRequest> call({required int toUserId, required String message}) {
    return repository.sendConversationRequest(toUserId: toUserId, message: message);
  }
}
