
import 'package:dartz/dartz.dart';

import '../entity/conversation_request.dart';
import '../repository/conversation_repository.dart';

class SendConversationRequestUseCase {
  final ConversationRepository repository;

  SendConversationRequestUseCase(this.repository);

  Future<Either<Exception, ConversationRequest>> call({
    required int toUserId,
    required String message,
  }) {
    return repository.sendConversationRequest(
      toUserId: toUserId,
      message: message,
    );
  }
}
