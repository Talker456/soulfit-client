import '../entity/chat_room.dart';
import '../repository/conversation_request_repository.dart';
import 'dart:developer';

class AcceptConversationRequest {
  final ConversationRequestRepository repository;

  AcceptConversationRequest(this.repository);

  Future<ChatRoom> call(String userId) async{
    log('[UseCase] AcceptConversationRequest called with userId: $userId');
    final result = await repository.acceptConversationRequest(userId);
    log('[UseCase] ChatRoom returned from repository: ${result.id}');
    return result;
  }
}
