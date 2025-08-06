import '../entity/chat_request.dart';
import '../entity/chat_room.dart';
import '../entity/sent_chat_request.dart';

abstract class ConversationRequestRepository {
  Future<List<ChatRequest>> getReceivedConversationRequests();
  Future<List<SentChatRequest>> getSentConversationRequests();
  Future<ChatRoom> acceptConversationRequest(String userId);
  Future<void> rejectConversationRequest(String userId);
}

