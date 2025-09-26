import '../../domain/entity/survey.dart';
import 'question_model.dart';

class SurveyModel extends Survey {
  const SurveyModel({
    required super.sessionId,
    required List<QuestionModel> questions,
  }) : super(questions: questions);

  factory SurveyModel.fromJson(Map<String, dynamic> json) {
    return SurveyModel(
      sessionId: json['sessionId'],
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }
}
