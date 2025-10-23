import 'meeting_summary.dart';

class PaginatedMeetings {
  final List<MeetingSummary> content;
  final int totalPages;
  final int totalElements;
  final bool last;
  final int number;

  PaginatedMeetings({
    required this.content,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.number,
  });
}
