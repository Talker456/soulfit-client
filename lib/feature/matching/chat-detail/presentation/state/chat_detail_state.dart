import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';

sealed class ChatDetailState extends Equatable {
  const ChatDetailState();

  @override
  List<Object> get props => [];
}

class ChatDetailLoading extends ChatDetailState {}

class ChatDetailLoaded extends ChatDetailState {
  final List<ChatMessage> messages;
  final bool hasReachedMax;

  const ChatDetailLoaded({
    this.messages = const [],
    this.hasReachedMax = false,
  });

  ChatDetailLoaded copyWith({
    List<ChatMessage>? messages,
    bool? hasReachedMax,
  }) {
    return ChatDetailLoaded(
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [messages, hasReachedMax];
}

class ChatDetailError extends ChatDetailState {
  final String message;

  const ChatDetailError(this.message);

  @override
  List<Object> get props => [message];
}
