
import '../model/sent_chat_request_model.dart';
import '../model/chat_request_model.dart';

abstract class ConversationRequestRemoteDataSource {
  Future<List<ChatRequestModel>> getReceivedRequests();
  Future<List<SentChatRequestModel>> getSentRequests();
  Future<void> acceptRequest(int requestId);
  Future<void> rejectRequest(int requestId);
  Future<SentChatRequestModel> sendRequest({
    required int toUserId,
    required String message,
  });
}
