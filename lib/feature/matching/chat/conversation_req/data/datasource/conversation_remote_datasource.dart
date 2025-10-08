

import '../model/conversation_request_dto.dart';

abstract class ConversationRemoteDataSource {
  Future<ConversationRequestDto> sendConversationRequest({
    required int toUserId,
    required String message,
  });
}
