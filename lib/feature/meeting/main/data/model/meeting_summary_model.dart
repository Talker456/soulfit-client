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

  factory MeetingSummaryModel.fromServerJson(Map<String, dynamic> json) {
    // Safely access imageUrls and provide a default
    final imageUrls = json['imageUrls'] as List?;
    final thumbnailUrl = (imageUrls != null && imageUrls.isNotEmpty)
        ? imageUrls.first
        : 'https://picsum.photos/400/400'; // A default placeholder

    // Safely access location and map to region
    final location = json['location'] as Map<String, dynamic>?;
    final region = location != null ? {'province': location['city'] as String?, 'district': null} : null;

    return MeetingSummaryModel(
      meetingId: json['id'].toString(),
      title: json['title'] ?? '제목 없음',
      thumbnailUrl: thumbnailUrl,
      category: json['category'] ?? '기타',
      currentParticipants: json['currentParticipants'] ?? 0,
      maxParticipants: json['maxParticipants'] ?? 0,
      price: (json['fee'] as num?)?.toInt() ?? 0,
      region: region,
      date: json['meetingTime'] != null ? DateTime.parse(json['meetingTime']) : null,
      // The spec doesn't consistently provide a rating for a meeting summary.
      // This might come from a different endpoint or needs to be calculated.
      rating: (json['meetingRating'] as num?)?.toDouble(),
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