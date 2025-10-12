import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/paginated_meetings_model.dart';
import '../models/ai_summary_model.dart';
import '../models/hosting_record_model.dart';
import 'past_activity_remote_datasource.dart';

class PastActivityRemoteDataSourceImpl
    implements PastActivityRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String baseUrl;

  PastActivityRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.baseUrl,
  });

  @override
  Future<PaginatedMeetingsModel> getParticipatedMeetings({
    required int page,
    required int size,
  }) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // ✅ 백엔드 API 존재 확인됨
      final response = await client.get(
        Uri.parse(
            'http://$baseUrl:8080/api/me/meetings/participated?page=$page&size=$size'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return PaginatedMeetingsModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
        );
      } else {
        throw Exception(
            '과거 참여 내역 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedMeetingsModel> getApplicationMeetings({
    required int page,
    required int size,
  }) async {
    // ⚠️ TODO: 백엔드 API 엔드포인트 확인 필요
    // 현재 백엔드에 GET /api/me/meetings/applications 또는 유사한 엔드포인트가 있는지 확인 필요
    // POST /api/meeting/applications 만 존재하는 것으로 파악됨

    throw UnimplementedError(
      '모임 신청 내역 조회 API가 백엔드에 존재하지 않습니다. '
      '백엔드 팀에 GET /api/me/meetings/applications 엔드포인트 추가 요청 필요',
    );
  }

  @override
  Future<List<HostingRecordModel>> getHostedMeetings({
    required int page,
    required int size,
  }) async {
    // ⚠️ TODO: 백엔드 API 엔드포인트 확인 필요
    // 현재 백엔드에 GET /api/me/meetings/hosted 또는 유사한 엔드포인트가 있는지 확인 필요

    throw UnimplementedError(
      '과거 개설 내역 조회 API가 백엔드에 존재하지 않습니다. '
      '백엔드 팀에 GET /api/me/meetings/hosted 엔드포인트 추가 요청 필요',
    );
  }

  @override
  Future<AiSummaryModel> getAiSummary() async {
    // ⚠️ TODO: 백엔드 API 엔드포인트 확인 필요
    // AI 요약 정보를 제공하는 엔드포인트가 필요

    throw UnimplementedError(
      'AI 요약 정보 API가 백엔드에 존재하지 않습니다. '
      '백엔드 팀에 GET /api/me/activities/summary 또는 유사한 엔드포인트 추가 요청 필요',
    );
  }
}
