import '../entity/survey.dart';
import '../entity/survey_submission.dart';

abstract class SurveyRepository {
  Future<Survey> startSurvey(String testType);

  Future<void> submitSurvey(SurveySubmission submission);
}
