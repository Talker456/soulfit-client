import '../../domain/entities/paginated_meetings.dart';
import 'past_meeting_model.dart';

// Paginated Meetings Model
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
      content: (json['content'] as List?)
              ?.map((i) => PastMeetingModel.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['totalPages'] as int? ?? 0,
      totalElements: json['totalElements'] as int? ?? 0,
      last: json['last'] as bool? ?? false,
      number: json['number'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'content': content.map((e) => (e as PastMeetingModel).toJson()).toList(),
        'totalPages': totalPages,
        'totalElements': totalElements,
        'last': last,
        'number': number,
      };
}
