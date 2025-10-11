import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meeting.dart';
import '../../domain/usecases/create_meeting_usecase.dart';
import '../state/create_meeting_state.dart';

class CreateMeetingNotifier extends StateNotifier<CreateMeetingState> {
  static const totalSteps = 6;
  final CreateMeetingUseCase createMeetingUseCase;

  CreateMeetingNotifier(this.createMeetingUseCase)
      : super(CreateMeetingState(draft: MeetingDraft()));

  double get progress => (state.step + 1) / totalSteps;

  /// draft를 수정하고 즉시 리빌드 트리거
  void patch(void Function(MeetingDraft d) update) {
    update(state.draft);
    state = state.copyWith(draft: state.draft); // 변경 알림
  }

  /// 필요 시 리빌드만 트리거
  void notify() => state = state.copyWith(draft: state.draft);

  void setStep(int step) {
    if (step >= 0 && step < totalSteps) {
      state = state.copyWith(step: step);
    }
  }

  void next() {
    if (canGoNext()) setStep(state.step + 1);
  }

  void prev() {
    if (state.step > 0) setStep(state.step - 1);
  }

  bool canGoNext() {
    final d = state.draft;
    switch (state.step) {
      case 0:
        return d.title.trim().isNotEmpty && d.description.trim().isNotEmpty;
      case 1:
        return d.startDate != null &&
            d.endDate != null &&
            d.schedules.isNotEmpty;
      case 2:
        return d.meetingPlaceSearch.trim().isNotEmpty;
      case 3:
        return (d.capacity ?? 0) > 0 && (d.pricePerPerson ?? 0) >= 0;
      default:
        return true;
    }
  }

  String? validationMessage() {
    final d = state.draft;
    switch (state.step) {
      case 0:
        if (d.title.trim().isEmpty) return '제목을 입력해 주세요.';
        if (d.description.trim().isEmpty) return '설명을 입력해 주세요.';
        return null;
      case 1:
        if (d.startDate == null) return '시작일을 선택해 주세요.';
        if (d.endDate == null) return '종료일을 선택해 주세요.';
        if (d.schedules.isEmpty) return '세부일정을 1개 이상 추가해 주세요.';
        return null;
      case 2:
        if (d.meetingPlaceSearch.trim().isEmpty) return '모이는 장소를 입력/선택해 주세요.';
        return null;
      case 3:
        if ((d.capacity ?? 0) <= 0) return '최대 인원을 입력해 주세요.';
        if ((d.pricePerPerson ?? 0) < 0) return '1인당 비용을 올바르게 입력해 주세요.';
        return null;
      default:
        return null;
    }
  }

  String? tryNext() {
    final msg = validationMessage();
    if (msg != null) return msg;
    setStep(state.step + 1);
    return null;
  }

  Future<void> submit() async {
    state = state.copyWith(submitting: true, error: null);
    try {
      // MeetingDraft를 Meeting Entity로 변환
      final meeting = _draftToEntity(state.draft);

      // UseCase를 통한 모임 생성 API 호출
      await createMeetingUseCase.execute(meeting);

      setStep(5); // 완료
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(submitting: false);
    }
  }

  /// MeetingDraft를 Meeting Entity로 변환
  Meeting _draftToEntity(MeetingDraft draft) {
    return Meeting(
      title: draft.title,
      description: draft.description,
      keywords: draft.keywords,
      imageUrls: draft.imagePaths,
      startDate: draft.startDate ?? DateTime.now(),
      endDate: draft.endDate ?? DateTime.now(),
      schedules: draft.schedules
          .map((s) => ScheduleItem(
                minutes: s.minutes,
                title: s.title,
              ))
          .toList(),
      meetingPlace: draft.meetingPlaceSearch,
      meetingPlaceDetail: draft.meetingPlaceDetail,
      equipments: draft.equipments,
      pickUpAvailable: draft.pickUpAvailable,
      capacity: draft.capacity ?? 0,
      pricePerPerson: draft.pricePerPerson ?? 0,
      costNote: draft.costNote,
      requiredQuestion: draft.requiredQuestion,
    );
  }
}
