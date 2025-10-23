import '../models/survey_model.dart';
import '../models/survey_submission_model.dart';

abstract class SurveyRemoteDataSource {
  Future<SurveyModel> startSurvey(String testType);
  Future<void> submitSurvey(SurveySubmissionModel submission);
}