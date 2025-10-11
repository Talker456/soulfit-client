import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entity/meeting_application.dart';
import '../model/meeting_application_model.dart';
import 'meeting_apply_remote_datasource.dart';

class MeetingApplyRemoteDataSourceImpl implements MeetingApplyRemoteDataSource {
  final String baseUrl;
  final http.Client client;
  MeetingApplyRemoteDataSourceImpl({
    required this.baseUrl,
    required this.client,
  });

  @override
  Future<void> submit(MeetingApplication application) async {
    final model = MeetingApplicationModel.fromEntity(application);

    // TODO: 백엔드 API 명세 확인 필요
    // 실제 엔드포인트가 다음 중 하나일 수 있음:
    // - POST /api/meetings/{meetingId}/applications
    // - POST /api/meetings/{meetingId}/join
    // - POST /api/meeting/applications (현재 가정)
    final uri = Uri.parse('$baseUrl/api/meeting/applications');

    final res = await client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('신청 제출 실패(${res.statusCode})');
    }
  }
}
