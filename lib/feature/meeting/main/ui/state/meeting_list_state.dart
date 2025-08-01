import '../../domain/entity/meeting_summary.dart';

sealed class MeetingListState {
  const MeetingListState();
}

class MeetingListInitial extends MeetingListState {}

class MeetingListLoading extends MeetingListState {}

class MeetingListLoaded extends MeetingListState {
  final List<MeetingSummary> meetings;
  final bool hasNext; // 더 불러올 페이지가 있는지 여부

  const MeetingListLoaded(this.meetings, {required this.hasNext});
}

class MeetingListError extends MeetingListState {
  final String message;
  const MeetingListError(this.message);
}
