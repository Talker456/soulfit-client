import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';

sealed class OngoingChatState {}

class OngoingChatLoading extends OngoingChatState {}

class OngoingChatLoaded extends OngoingChatState {
  final List<OngoingChat> chats;

  OngoingChatLoaded(this.chats);
}

class OngoingChatError extends OngoingChatState {
  final String message;

  OngoingChatError(this.message);
}
