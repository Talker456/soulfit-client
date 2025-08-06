
import 'package:soulfit_client/feature/matching/chat/domain/entity/chat_room.dart';

import '../model/chat_request_model.dart';
import '../model/sent_chat_request_model.dart';

abstract class ConversationRequestRemoteDataSource {
  Future<List<ChatRequestModel>> getReceivedRequests();
  Future<List<SentChatRequestModel>> getSentRequests();
  Future<ChatRoom> acceptRequest(String userId);
  Future<void> rejectRequest(String userId);
}
