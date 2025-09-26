// lib/feature/user_report/data/datasources/user_report_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../feature/authentication/data/datasource/auth_local_datasource.dart';

abstract class UserReportRemoteDataSource {
  Future<void> reportUser({
    required String reporterUserId,
    required String reportedUserId,
    required String reason,
  });
}

class UserReportRemoteDataSourceImpl implements UserReportRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String baseUrl;

  UserReportRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.baseUrl,
  });

  @override
  Future<void> reportUser({
    required String reporterUserId,
    required String reportedUserId,
    required String reason,
  }) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/report/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'reporter_user_id': reporterUserId,
          'reported_user_id': reportedUserId,
          'reason': reason,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('신고에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
