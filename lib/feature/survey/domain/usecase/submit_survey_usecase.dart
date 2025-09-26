import '../entity/survey_submission.dart';
import '../repository/survey_repository.dart';

class SubmitSurveyUseCase {
  final SurveyRepository _repository;

  SubmitSurveyUseCase(this._repository);

  Future<void> call(SurveySubmission submission) {
    return _repository.submitSurvey(submission);
  }
}
