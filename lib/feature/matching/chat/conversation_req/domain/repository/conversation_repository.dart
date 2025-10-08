
import 'package:dartz/dartz.dart';

import '../entity/conversation_request.dart';

abstract class ConversationRepository {
  Future<Either<Exception, ConversationRequest>> sendConversationRequest({
    required int toUserId,
    required String message,
  });
}
