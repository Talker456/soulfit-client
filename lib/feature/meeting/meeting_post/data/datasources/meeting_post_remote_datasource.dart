import '../models/meeting_post_detail_model.dart';

/// 모임 상세 정보 Remote DataSource Interface
abstract class MeetingPostRemoteDataSource {
  /// 모임 상세 정보 조회
  /// [meetingId] 조회할 모임 ID
  /// Returns: 모임 상세 정보 Model
  Future<MeetingPostDetailModel> getMeetingPostDetail(String meetingId);
}
