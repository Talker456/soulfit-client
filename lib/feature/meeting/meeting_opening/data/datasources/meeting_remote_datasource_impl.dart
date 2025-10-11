import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/meeting_model.dart';
import 'meeting_remote_datasource.dart';

/// Meeting Remote DataSource 구현
/// 백엔드 API와 실제 통신을 담당
class MeetingRemoteDataSourceImpl implements MeetingRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  MeetingRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<int> createMeeting(MeetingModel meeting) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 실제 엔드포인트가 다음 중 하나일 수 있음:
      // - POST /api/meetings (가장 일반적)
      // - POST /api/meetings/create
      // - POST /api/meeting (단수형)
      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/meetings'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(meeting.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody);

        // 응답에서 생성된 모임 ID 추출
        // API 응답 형식에 따라 수정 필요
        if (jsonResponse is Map<String, dynamic>) {
          return jsonResponse['id'] as int? ??
                 jsonResponse['meetingId'] as int? ??
                 0;
        }
        return 0;
      } else {
        throw Exception('모임 생성에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('모임 생성 요청 실패: $e');
    }
  }
}
