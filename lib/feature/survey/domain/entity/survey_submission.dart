import 'package:equatable/equatable.dart';

class SurveySubmission extends Equatable {
  final int sessionId;
  final List<Answer> answers;

  const SurveySubmission({
    required this.sessionId,
    required this.answers,
  });

  @override
  List<Object?> get props => [sessionId, answers];
}

class Answer extends Equatable {
  final int questionId;
  final int? selectedChoiceId;
  final String? answerText;

  const Answer({
    required this.questionId,
    this.selectedChoiceId,
    this.answerText,
  });

  @override
  List<Object?> get props => [questionId, selectedChoiceId, answerText];
}
