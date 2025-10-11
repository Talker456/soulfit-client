import '../entities/meeting.dart';

/// Meeting Repository Interface
/// 모임 개설 관련 비즈니스 로직 인터페이스
abstract class MeetingRepository {
  /// 모임 생성
  /// [meeting] 생성할 모임 정보
  /// Returns: 생성된 모임 ID
  Future<int> createMeeting(Meeting meeting);
}
