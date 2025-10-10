import '../../domain/entity/meeting_summary.dart';

class MeetingSummaryModel extends MeetingSummary {
  MeetingSummaryModel({
    required super.id,
    required super.title,
    required super.category,
    required super.city,
    required super.fee,
    required super.maxParticipants,
    required super.currentParticipants,
    required super.status,
  });

  factory MeetingSummaryModel.fromJson(Map<String, dynamic> json) {
    return MeetingSummaryModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      city: (json['location'] as Map<String, dynamic>?)?['city'] as String? ?? '',
      fee: json['fee'] as int? ?? 0,
      maxParticipants: json['maxParticipants'] as int? ?? 0,
      currentParticipants: json['currentParticipants'] as int? ?? 0,
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'location': {'city': city},
    'fee': fee,
    'maxParticipants': maxParticipants,
    'currentParticipants': currentParticipants,
    'status': status,
  };
}