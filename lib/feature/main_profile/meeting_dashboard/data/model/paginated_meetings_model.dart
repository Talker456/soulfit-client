import './meeting_summary_model.dart';
import '../../domain/entity/paginated_meetings.dart';

class PaginatedMeetingsModel extends PaginatedMeetings {
  PaginatedMeetingsModel({
    required super.content,
    required super.totalPages,
    required super.totalElements,
    required super.last,
    required super.number,
  });

  factory PaginatedMeetingsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedMeetingsModel(
      content: (json['content'] as List?)?.map((i) => MeetingSummaryModel.fromJson(i as Map<String, dynamic>)).toList() ?? [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalElements: json['totalElements'] as int? ?? 0,
      last: json['last'] as bool? ?? false,
      number: json['number'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'content': content.map((e) => (e as MeetingSummaryModel).toJson()).toList(),
    'totalPages': totalPages,
    'totalElements': totalElements,
    'last': last,
    'number': number,
  };
}
