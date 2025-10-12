// lib/feature/meeting_report/data/datasources/meeting_report_remote_datasource.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../feature/authentication/data/datasource/auth_local_datasource.dart';
import '../models/meeting_report_request.dart';

abstract class MeetingReportRemoteDataSource {
  Future<void> reportMeeting(MeetingReportRequest request);
}

class MeetingReportRemoteDataSourceImpl implements MeetingReportRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String baseUrl;

  MeetingReportRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.baseUrl,
  });

  @override
  Future<void> reportMeeting(MeetingReportRequest request) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 현재는 user_report와 일관성있게 /api/reports/meeting 사용
      // 백엔드에서 다른 엔드포인트를 사용한다면 수정 필요
      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/reports/meeting'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('모임 신고에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
