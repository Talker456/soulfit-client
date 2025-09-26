import '../../domain/entity/survey.dart';
import '../../domain/entity/survey_submission.dart';
import '../../domain/repository/survey_repository.dart';
import '../datasource/survey_remote_data_source.dart';
import '../models/survey_submission_model.dart';

class SurveyRepositoryImpl implements SurveyRepository {
  final SurveyRemoteDataSource remoteDataSource;

  SurveyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Survey> startSurvey(String testType) async {
    try {
      final surveyModel = await remoteDataSource.startSurvey(testType);
      return surveyModel;
    } on Exception catch (e) {
      throw Exception('Failed to start survey: $e');
    }
  }

  @override
  Future<void> submitSurvey(SurveySubmission submission) async {
    try {
      final submissionModel = SurveySubmissionModel.fromEntity(submission);
      await remoteDataSource.submitSurvey(submissionModel);
    } on Exception catch (e) {
      throw Exception('Failed to submit survey: $e');
    }
  }
}

