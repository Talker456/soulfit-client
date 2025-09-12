import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_analysis.dart';

sealed class ChatAnalysisState extends Equatable {
  const ChatAnalysisState();

  @override
  List<Object?> get props => [];
}

class ChatAnalysisInitial extends ChatAnalysisState {}

class ChatAnalysisLoading extends ChatAnalysisState {}

class ChatAnalysisLoaded extends ChatAnalysisState {
  final ChatAnalysis analysis;

  const ChatAnalysisLoaded(this.analysis);

  @override
  List<Object?> get props => [analysis];
}

class ChatAnalysisError extends ChatAnalysisState {
  final String message;

  const ChatAnalysisError(this.message);

  @override
  List<Object?> get props => [message];
}
