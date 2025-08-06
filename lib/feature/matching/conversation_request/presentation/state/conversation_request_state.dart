
import '../../domain/entity/chat_request.dart';

sealed class ConversationRequestState {}

class ConversationRequestLoading extends ConversationRequestState {}

class ConversationRequestLoaded extends ConversationRequestState {
  final List<ChatRequest> requests;

  ConversationRequestLoaded(this.requests);
}

class ConversationRequestError extends ConversationRequestState {
  final String message;

  ConversationRequestError(this.message);
}
