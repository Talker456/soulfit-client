// import '../../../domain/entity/meeting_summary.dart';

import '../../domain/entity/meeting_summary.dart';

class MeetingSummaryModel extends MeetingSummary {
  const MeetingSummaryModel({
    required super.meetingId,
    required super.title,
    required super.thumbnailUrl,
    required super.category,
    required super.currentParticipants,
    required super.maxParticipants,
    required super.price,
  });

  factory MeetingSummaryModel.fromJson(Map<String, dynamic> json) {
    return MeetingSummaryModel(
      meetingId: json['meetingId'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      category: json['category'],
      currentParticipants: json['currentParticipants'],
      maxParticipants: json['maxParticipants'],
      price: json['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
      'title': title,
      'thumbnailUrl': thumbnailUrl,
      'category': category,
      'currentParticipants': currentParticipants,
      'maxParticipants': maxParticipants,
      'price': price,
    };
  }
}
