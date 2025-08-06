import 'package:soulfit_client/feature/matching/conversation_request/domain/entity/chat_room.dart';

import '../model/chat_request_model.dart';

abstract class ConversationRequestRemoteDataSource {
  Future<List<ChatRequestModel>> getReceivedRequests();

  Future<ChatRoom> acceptRequest(String userId);

  Future<void> rejectRequest(String userId);
}
