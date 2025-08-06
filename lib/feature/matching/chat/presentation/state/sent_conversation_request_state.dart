import '../../domain/entity/sent_chat_request.dart';

sealed class SentConversationRequestState {}

class SentConversationRequestLoading extends SentConversationRequestState {}

class SentConversationRequestLoaded extends SentConversationRequestState {
  final List<SentChatRequest> requests;

  SentConversationRequestLoaded(this.requests);
}

class SentConversationRequestError extends SentConversationRequestState {
  final String message;

  SentConversationRequestError(this.message);
}
