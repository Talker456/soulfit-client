
import 'test_choice.dart';

enum QuestionType {
  multiple,
  text,
}

class TestAnswer {
  final int questionId;
  final String questionContent;
  final QuestionType questionType;
  final List<TestChoice> choices;
  final int? selectedChoiceId;
  final String? answerText;

  TestAnswer({
    required this.questionId,
    required this.questionContent,
    required this.questionType,
    required this.choices,
    this.selectedChoiceId,
    this.answerText,
  });
}
