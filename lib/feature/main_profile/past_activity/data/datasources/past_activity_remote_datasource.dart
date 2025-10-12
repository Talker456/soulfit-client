import '../models/paginated_meetings_model.dart';
import '../models/ai_summary_model.dart';
import '../models/hosting_record_model.dart';

// Past Activity Remote DataSource Interface
abstract class PastActivityRemoteDataSource {
  /// 과거 참여 내역 조회
  Future<PaginatedMeetingsModel> getParticipatedMeetings({
    required int page,
    required int size,
  });

  /// 모임 신청 내역 조회
  Future<PaginatedMeetingsModel> getApplicationMeetings({
    required int page,
    required int size,
  });

  /// 과거 개설 내역 조회
  Future<List<HostingRecordModel>> getHostedMeetings({
    required int page,
    required int size,
  });

  /// AI 요약 정보 조회
  Future<AiSummaryModel> getAiSummary();
}
