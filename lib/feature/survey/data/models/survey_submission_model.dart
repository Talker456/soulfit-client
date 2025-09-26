import '../../domain/entity/survey_submission.dart';

class SurveySubmissionModel extends SurveySubmission {
  const SurveySubmissionModel({
    required super.sessionId,
    required super.answers,
  });

  factory SurveySubmissionModel.fromEntity(SurveySubmission entity) {
    return SurveySubmissionModel(
      sessionId: entity.sessionId,
      answers: entity.answers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'answers': answers
          .map((a) => {
                'questionId': a.questionId,
                'selectedChoiceId': a.selectedChoiceId,
                'answerText': a.answerText,
              })
          .toList(),
    };
  }
}
