// 피그마에는 없는 화면, 어플 내에 없는 화면임.
// 나중에 필요 시 이 화면도 추가 예정

import '../entity/meeting_application.dart';
import '../repository/meeting_application_repository.dart';

class SubmitMeetingApplicationUseCase {
  final MeetingApplicationRepository _repo;
  SubmitMeetingApplicationUseCase(this._repo);

  Future<bool> call(MeetingApplication application) async {
    // 간단 검증 (UI 1차, UseCase 2차)
    if (application.applicantName.trim().isEmpty) {
      throw ArgumentError('신청자 이름을 입력해주세요.');
    }
    if (application.contact.trim().isEmpty) {
      throw ArgumentError('연락처를 입력해주세요.');
    }
    if (!application.agreeTerms) {
      throw ArgumentError('약관에 동의해주세요.');
    }
    return _repo.submit(application);
  }
}
