class ScheduleItem {
  int minutes;
  String title;
  ScheduleItem({this.minutes = 0, this.title = ''});
}

class MeetingDraft {
  // 1단계
  String title = '';
  String description = '';
  List<String> keywords = [];
  List<String> imagePaths = [];

  // 2단계
  DateTime? startDate;
  DateTime? endDate;
  List<ScheduleItem> schedules = [ScheduleItem()];

  // 3단계
  String meetingPlaceSearch = '';
  String meetingPlaceDetail = '';

  // 4단계
  List<String> equipments = [''];
  bool pickUpAvailable = true;
  int? capacity;
  int? pricePerPerson;
  String costNote = '';

  // 5단계
  String requiredQuestion = '';
}

class CreateMeetingState {
  final int step; // 0..5
  final MeetingDraft draft;
  final bool submitting;
  final String? error;

  const CreateMeetingState({
    this.step = 0,
    required this.draft,
    this.submitting = false,
    this.error,
  });

  CreateMeetingState copyWith({
    int? step,
    MeetingDraft? draft,
    bool? submitting,
    String? error,
  }) {
    return CreateMeetingState(
      step: step ?? this.step,
      draft: draft ?? this.draft,
      submitting: submitting ?? this.submitting,
      error: error,
    );
  }
}
