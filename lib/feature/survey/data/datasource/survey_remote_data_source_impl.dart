import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/survey_model.dart';
import '../models/survey_submission_model.dart';
import 'survey_remote_data_source.dart';

class SurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String base;


  SurveyRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    this.base = 'localhost:8080', // Default value, can be overridden by provider
  });

  @override
  Future<SurveyModel> startSurvey(String testType) async {
    final accessToken = await authSource.getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    final response = await client.post(
      Uri.parse('http://$base/api/tests/start?testType=$testType'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + accessToken,
      },
    );

    if (response.statusCode == 200) {
      return SurveyModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to start survey. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<void> submitSurvey(SurveySubmissionModel submission) async {
    final accessToken = await authSource.getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    final response = await client.post(
      Uri.parse('http://$base/api/tests/submit'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + accessToken,
      },
      body: jsonEncode(submission.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit survey. Status code: ${response.statusCode}');
    }
  }
}