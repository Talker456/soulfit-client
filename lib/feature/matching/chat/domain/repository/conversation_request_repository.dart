import '../entity/chat_request.dart';
import '../entity/chat_room.dart';

abstract class ConversationRequestRepository {
  Future<List<ChatRequest>> getReceivedConversationRequests();
  Future<ChatRoom> acceptConversationRequest(String userId); // ✅ 수정
  Future<void> rejectConversationRequest(String userId);
}

