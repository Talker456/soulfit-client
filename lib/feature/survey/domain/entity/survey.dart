import 'package:equatable/equatable.dart';
import 'question.dart';

class Survey extends Equatable {
  final int sessionId;
  final List<Question> questions;

  const Survey({
    required this.sessionId,
    required this.questions,
  });

  @override
  List<Object?> get props => [sessionId, questions];
}
