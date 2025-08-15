import '../repository/conversation_request_repository.dart';

class AcceptConversationRequest {
  final ConversationRequestRepository repository;

  AcceptConversationRequest(this.repository);

  Future<void> call(int requestId) async {
    return repository.acceptConversationRequest(requestId);
  }
}
