import '../entities/meeting.dart';
import '../repositories/meeting_repository.dart';

/// 모임 생성 UseCase
class CreateMeetingUseCase {
  final MeetingRepository repository;

  CreateMeetingUseCase(this.repository);

  /// 모임 생성 실행
  /// [meeting] 생성할 모임 정보
  /// Returns: 생성된 모임 ID
  Future<int> execute(Meeting meeting) async {
    // 비즈니스 로직 검증
    if (meeting.title.trim().isEmpty) {
      throw Exception('모임 제목은 필수입니다');
    }
    if (meeting.description.trim().isEmpty) {
      throw Exception('모임 설명은 필수입니다');
    }
    if (meeting.capacity <= 0) {
      throw Exception('최대 인원은 1명 이상이어야 합니다');
    }
    if (meeting.pricePerPerson < 0) {
      throw Exception('1인당 비용은 0원 이상이어야 합니다');
    }
    if (meeting.startDate.isAfter(meeting.endDate)) {
      throw Exception('시작일은 종료일보다 앞서야 합니다');
    }

    return await repository.createMeeting(meeting);
  }
}
