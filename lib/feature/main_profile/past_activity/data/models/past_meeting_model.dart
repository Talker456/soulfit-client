import '../../domain/entities/past_meeting.dart';

// Past Meeting Model (DTO)
class PastMeetingModel extends PastMeeting {
  PastMeetingModel({
    required super.id,
    required super.date,
    required super.title,
    required super.location,
    required super.price,
    required super.currentParticipants,
    required super.maxParticipants,
    super.imageUrl,
    required super.status,
  });

  factory PastMeetingModel.fromJson(Map<String, dynamic> json) {
    return PastMeetingModel(
      id: json['id'] as int? ?? 0,
      date: json['date'] as String? ?? '',
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? json['city'] as String? ?? '',
      price: json['price'] as int? ?? json['fee'] as int? ?? 0,
      currentParticipants: json['currentParticipants'] as int? ?? 0,
      maxParticipants: json['maxParticipants'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'title': title,
        'location': location,
        'price': price,
        'currentParticipants': currentParticipants,
        'maxParticipants': maxParticipants,
        'imageUrl': imageUrl,
        'status': status,
      };
}
