import '../../domain/entity/question.dart';
import 'choice_model.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.content,
    required super.type,
    required List<ChoiceModel> choices,
  }) : super(choices: choices);

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      content: json['content'],
      type: (json['type'] as String).toQuestionType(),
      choices: (json['choices'] as List)
          .map((c) => ChoiceModel.fromJson(c))
          .toList(),
    );
  }
}

extension on String {
  QuestionType toQuestionType() {
    switch (this) {
      case 'MULTIPLE':
        return QuestionType.multiple;
      case 'TEXT':
        return QuestionType.text;
      default:
        throw Exception('Unknown QuestionType: $this');
    }
  }
}
