import '../entity/chat_request.dart';
import '../entity/sent_chat_request.dart';

abstract class ConversationRequestRepository {
  Future<List<ChatRequest>> getReceivedConversationRequests();
  Future<List<SentChatRequest>> getSentConversationRequests();
  Future<void> acceptConversationRequest(int requestId);
  Future<void> rejectConversationRequest(int requestId);
  Future<SentChatRequest> sendConversationRequest(
      {required int toUserId, required String message});
}

