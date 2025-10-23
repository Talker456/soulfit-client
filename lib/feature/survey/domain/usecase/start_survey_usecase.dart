import '../entity/survey.dart';
import '../repository/survey_repository.dart';

class StartSurveyUseCase {
  final SurveyRepository _repository;

  StartSurveyUseCase(this._repository);

  Future<Survey> call(String testType) {
    return _repository.startSurvey(testType);
  }
}
