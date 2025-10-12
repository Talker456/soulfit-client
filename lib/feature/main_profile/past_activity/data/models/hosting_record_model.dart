import '../../domain/entities/hosting_record.dart';

// Hosting Record Model
class HostingRecordModel extends HostingRecord {
  HostingRecordModel({
    required super.id,
    required super.title,
    required super.location,
    required super.participants,
    required super.revenue,
    super.imageUrl,
    required super.date,
  });

  factory HostingRecordModel.fromJson(Map<String, dynamic> json) {
    return HostingRecordModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      location: json['location'] as String? ?? '',
      participants: json['participants'] as int? ?? 0,
      revenue: json['revenue'] as int? ?? 0,
      imageUrl: json['imageUrl'] as String?,
      date: json['date'] != null
          ? DateTime.parse(json['date'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'location': location,
        'participants': participants,
        'revenue': revenue,
        'imageUrl': imageUrl,
        'date': date.toIso8601String(),
      };
}
