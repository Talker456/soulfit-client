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
    final uri = Uri.parse('$baseUrl/api/meeting/applications'); // 예시 엔드포인트
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
