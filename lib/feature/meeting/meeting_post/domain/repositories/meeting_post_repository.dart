import '../entities/meeting_post_detail.dart';

/// 모임 상세 정보 Repository Interface
abstract class MeetingPostRepository {
  /// 모임 상세 정보 조회
  /// [meetingId] 조회할 모임 ID
  /// Returns: 모임 상세 정보
  Future<MeetingPostDetail> getMeetingPostDetail(String meetingId);
}
