import '../../domain/entity/meeting_summary.dart';

sealed class MeetingListState {
  const MeetingListState();
}

class MeetingListInitial extends MeetingListState {}

class MeetingListLoading extends MeetingListState {}

class MeetingListLoaded extends MeetingListState {
  final List<MeetingSummary> meetings;
  final bool hasNext; // 더 불러올 페이지가 있는지 여부
  final List<String> recommendationTags;

  const MeetingListLoaded(this.meetings, {required this.hasNext, this.recommendationTags = const []});

  MeetingListLoaded copyWith({
    List<MeetingSummary>? meetings,
    bool? hasNext,
    List<String>? recommendationTags,
  }) {
    return MeetingListLoaded(
      meetings ?? this.meetings,
      hasNext: hasNext ?? this.hasNext,
      recommendationTags: recommendationTags ?? this.recommendationTags,
    );
  }
}

class MeetingListError extends MeetingListState {
  final String message;
  const MeetingListError(this.message);
}
