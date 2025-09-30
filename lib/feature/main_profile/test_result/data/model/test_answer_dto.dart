
import '../../domain/entity/test_answer.dart';
import 'test_choice_dto.dart';

class TestAnswerDto {
  final int questionId;
  final String questionContent;
  final String questionType;
  final List<TestChoiceDto> choices;
  final int? selectedChoiceId;
  final String? answerText;

  TestAnswerDto({
    required this.questionId,
    required this.questionContent,
    required this.questionType,
    required this.choices,
    this.selectedChoiceId,
    this.answerText,
  });

  factory TestAnswerDto.fromJson(Map<String, dynamic> json) {
    return TestAnswerDto(
      questionId: json['questionId'],
      questionContent: json['questionContent'],
      questionType: json['questionType'],
      choices: (json['choices'] as List)
          .map((e) => TestChoiceDto.fromJson(e))
          .toList(),
      selectedChoiceId: json['selectedChoiceId'],
      answerText: json['answerText'],
    );
  }

  TestAnswer toEntity() {
    return TestAnswer(
      questionId: questionId,
      questionContent: questionContent,
      questionType: questionType.toLowerCase() == 'multiple'
          ? QuestionType.multiple
          : QuestionType.text,
      choices: choices.map((e) => e.toEntity()).toList(),
      selectedChoiceId: selectedChoiceId,
      answerText: answerText,
    );
  }
}
