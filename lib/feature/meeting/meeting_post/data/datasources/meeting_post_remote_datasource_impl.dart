import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/meeting_post_detail_model.dart';
import 'meeting_post_remote_datasource.dart';

/// 모임 상세 정보 Remote DataSource 구현
/// 백엔드 API와 실제 통신을 담당
class MeetingPostRemoteDataSourceImpl implements MeetingPostRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  MeetingPostRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<MeetingPostDetailModel> getMeetingPostDetail(String meetingId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - GET /api/meetings/{meetingId}
      // - GET /api/meetings/{meetingId}/detail
      // - GET /api/meeting/{meetingId}
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/meetings/$meetingId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody);

        print('[meeting d-src impl] : ' + response.body.toString());

        return MeetingPostDetailModel.fromJson(jsonResponse);
      } else {
        throw Exception('모임 상세 정보 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('모임 상세 정보 요청 실패: $e');
    }
  }
}
