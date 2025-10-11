import '../../domain/entities/meeting.dart';

/// 모임 Model (DTO)
/// API 요청과 Entity 간 변환을 담당
class MeetingModel extends Meeting {
  const MeetingModel({
    required super.title,
    required super.description,
    required super.keywords,
    required super.imageUrls,
    required super.startDate,
    required super.endDate,
    required super.schedules,
    required super.meetingPlace,
    required super.meetingPlaceDetail,
    required super.equipments,
    required super.pickUpAvailable,
    required super.capacity,
    required super.pricePerPerson,
    required super.costNote,
    required super.requiredQuestion,
  });

  /// Entity에서 Model 생성
  factory MeetingModel.fromEntity(Meeting entity) {
    return MeetingModel(
      title: entity.title,
      description: entity.description,
      keywords: entity.keywords,
      imageUrls: entity.imageUrls,
      startDate: entity.startDate,
      endDate: entity.endDate,
      schedules: entity.schedules
          .map((s) => ScheduleItemModel.fromEntity(s))
          .toList(),
      meetingPlace: entity.meetingPlace,
      meetingPlaceDetail: entity.meetingPlaceDetail,
      equipments: entity.equipments,
      pickUpAvailable: entity.pickUpAvailable,
      capacity: entity.capacity,
      pricePerPerson: entity.pricePerPerson,
      costNote: entity.costNote,
      requiredQuestion: entity.requiredQuestion,
    );
  }

  /// Model을 JSON으로 변환 (API 요청용)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'keywords': keywords,
      'imageUrls': imageUrls,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'schedules': schedules
          .map((s) => ScheduleItemModel.fromEntity(s).toJson())
          .toList(),
      'meetingPlace': meetingPlace,
      'meetingPlaceDetail': meetingPlaceDetail,
      'equipments': equipments,
      'pickUpAvailable': pickUpAvailable,
      'capacity': capacity,
      'pricePerPerson': pricePerPerson,
      'costNote': costNote,
      'requiredQuestion': requiredQuestion,
    };
  }

  /// JSON에서 Model 생성 (API 응답용)
  factory MeetingModel.fromJson(Map<String, dynamic> json) {
    return MeetingModel(
      title: json['title'] as String,
      description: json['description'] as String,
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) =>
                  ScheduleItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      meetingPlace: json['meetingPlace'] as String,
      meetingPlaceDetail: json['meetingPlaceDetail'] as String? ?? '',
      equipments: (json['equipments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      pickUpAvailable: json['pickUpAvailable'] as bool? ?? false,
      capacity: json['capacity'] as int,
      pricePerPerson: json['pricePerPerson'] as int,
      costNote: json['costNote'] as String? ?? '',
      requiredQuestion: json['requiredQuestion'] as String? ?? '',
    );
  }
}

/// 일정 아이템 Model
class ScheduleItemModel extends ScheduleItem {
  const ScheduleItemModel({
    required super.minutes,
    required super.title,
  });

  factory ScheduleItemModel.fromEntity(ScheduleItem entity) {
    return ScheduleItemModel(
      minutes: entity.minutes,
      title: entity.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'minutes': minutes,
      'title': title,
    };
  }

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    return ScheduleItemModel(
      minutes: json['minutes'] as int,
      title: json['title'] as String,
    );
  }
}
