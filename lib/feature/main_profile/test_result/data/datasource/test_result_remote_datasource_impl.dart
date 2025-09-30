
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';

import '../model/test_result_dto.dart';
import 'test_result_remote_datasource.dart';

class TestResultRemoteDataSourceImpl implements TestResultRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  final String base;

  TestResultRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.base,
  });

  @override
  Future<TestResultDto> fetchTestResult(String testType) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/tests/results?testType=$testType'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('[Debug - fetchTestResult] Response Status Code: ${response.statusCode}');
    print('[Debug - fetchTestResult] Response Body: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return TestResultDto.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load test results');
    }
  }
}
