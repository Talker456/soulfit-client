import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../feature/authentication/data/datasource/auth_local_datasource.dart';
import '../models/user_report_request.dart';

abstract class UserReportRemoteDataSource {
  Future<void> reportUser(UserReportRequestDto request);
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
  Future<void> reportUser(UserReportRequestDto request) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/reports'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('신고에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
