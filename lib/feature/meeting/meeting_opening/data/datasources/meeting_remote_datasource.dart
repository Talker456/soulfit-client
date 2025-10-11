import '../models/meeting_model.dart';

/// Meeting Remote DataSource Interface
/// 백엔드 API와 통신하는 인터페이스
abstract class MeetingRemoteDataSource {
  /// 모임 생성
  /// [meeting] 생성할 모임 정보
  /// Returns: 생성된 모임 ID
  Future<int> createMeeting(MeetingModel meeting);
}
