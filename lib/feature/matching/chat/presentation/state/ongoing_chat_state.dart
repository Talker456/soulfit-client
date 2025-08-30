import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat/domain/entity/ongoing_chat.dart';

sealed class OngoingChatState extends Equatable {
  const OngoingChatState();

  @override
  List<Object> get props => [];
}

class OngoingChatLoading extends OngoingChatState {}

class OngoingChatLoaded extends OngoingChatState {
  final List<OngoingChat> chats;
  final bool hasReachedMax;

  const OngoingChatLoaded({
    this.chats = const [],
    this.hasReachedMax = false,
  });

  OngoingChatLoaded copyWith({
    List<OngoingChat>? chats,
    bool? hasReachedMax,
  }) {
    return OngoingChatLoaded(
      chats: chats ?? this.chats,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [chats, hasReachedMax];
}

class OngoingChatError extends OngoingChatState {
  final String message;

  const OngoingChatError(this.message);

  @override
  List<Object> get props => [message];
}
