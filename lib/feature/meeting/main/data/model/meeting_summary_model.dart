import '../../domain/entity/meeting_summary.dart';

class MeetingSummaryModel extends MeetingSummary {
  final DateTime? date;
  final double? rating;

  const MeetingSummaryModel({
    required super.meetingId,
    required super.title,
    required super.thumbnailUrl,
    required super.category,
    required super.currentParticipants,
    required super.maxParticipants,
    required super.price,
    super.region, // Added super.region
    this.date,
    this.rating,
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
      region: json['region'] != null ? Map<String, String?>.from(json['region']) : null, // Added region parsing
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
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
      'region': region, // Added region serialization
      'date': date?.toIso8601String(),
      'rating': rating,
    };
  }
}