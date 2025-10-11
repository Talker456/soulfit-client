import '../entities/meeting_post_detail.dart';
import '../repositories/meeting_post_repository.dart';

/// 모임 상세 정보 조회 UseCase
class GetMeetingPostDetailUseCase {
  final MeetingPostRepository repository;

  GetMeetingPostDetailUseCase(this.repository);

  /// 모임 상세 정보를 조회합니다
  /// [meetingId] 조회할 모임 ID
  /// Returns: 모임 상세 정보
  Future<MeetingPostDetail> execute(String meetingId) async {
    if (meetingId.trim().isEmpty) {
      throw Exception('모임 ID가 유효하지 않습니다');
    }

    return await repository.getMeetingPostDetail(meetingId);
  }
}
