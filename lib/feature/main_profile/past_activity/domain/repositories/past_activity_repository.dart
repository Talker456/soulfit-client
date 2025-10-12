import '../entities/paginated_meetings.dart';
import '../entities/ai_summary.dart';
import '../entities/hosting_record.dart';

// Past Activity Repository Interface
abstract class PastActivityRepository {
  /// 과거 참여 내역 조회
  /// [page]: 페이지 번호 (0부터 시작)
  /// [size]: 페이지 크기
  Future<PaginatedMeetings> getParticipatedMeetings({
    required int page,
    required int size,
  });

  /// 모임 신청 내역 조회
  /// TODO: 백엔드 API 엔드포인트 확인 필요
  /// 현재 백엔드에 GET /api/me/meetings/applications 또는 유사한 엔드포인트가 있는지 확인 필요
  Future<PaginatedMeetings> getApplicationMeetings({
    required int page,
    required int size,
  });

  /// 과거 개설 내역 조회 (호스트)
  /// TODO: 백엔드 API 엔드포인트 확인 필요
  /// 현재 백엔드에 GET /api/me/meetings/hosted 또는 유사한 엔드포인트가 있는지 확인 필요
  Future<List<HostingRecord>> getHostedMeetings({
    required int page,
    required int size,
  });

  /// AI 요약 정보 조회
  /// TODO: 백엔드 API 엔드포인트 확인 필요
  Future<AiSummary> getAiSummary();
}
