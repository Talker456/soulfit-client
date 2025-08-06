import '../repository/conversation_request_repository.dart';

class RejectConversationRequest {
  final ConversationRequestRepository repository;

  RejectConversationRequest(this.repository);

  Future<void> call(String userId) {
    return repository.rejectConversationRequest(userId);
  }
}
