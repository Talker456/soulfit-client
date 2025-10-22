import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/recommended_replies.dart';

sealed class ChatDetailState extends Equatable {
  const ChatDetailState();

  @override
  List<Object> get props => [];
}

class ChatDetailLoading extends ChatDetailState {}

class ChatDetailLoaded extends ChatDetailState {
  final List<ChatMessage> messages;
  final bool hasReachedMax;
  final List<Recommendation>? recommendedReplies;
  final bool isFetchingRecommendations;

  const ChatDetailLoaded({
    this.messages = const [],
    this.hasReachedMax = false,
    this.recommendedReplies,
    this.isFetchingRecommendations = false,
  });

  ChatDetailLoaded copyWith({
    List<ChatMessage>? messages,
    bool? hasReachedMax,
    List<Recommendation>? recommendedReplies,
    bool? isFetchingRecommendations,
  }) {
    return ChatDetailLoaded(
      messages: messages ?? this.messages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      recommendedReplies: recommendedReplies ?? this.recommendedReplies,
      isFetchingRecommendations:
          isFetchingRecommendations ?? this.isFetchingRecommendations,
    );
  }

  @override
  List<Object> get props => [messages, hasReachedMax, isFetchingRecommendations];
}

class ChatDetailError extends ChatDetailState {
  final String message;

  const ChatDetailError(this.message);

  @override
  List<Object> get props => [message];
}
