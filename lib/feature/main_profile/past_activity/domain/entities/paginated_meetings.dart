import 'past_meeting.dart';

// 페이지네이션된 모임 목록 Entity
class PaginatedMeetings {
  final List<PastMeeting> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int number; // 현재 페이지 번호

  PaginatedMeetings({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.number,
  });
}
