/// 모임 Entity
/// 모임 생성/개설을 위한 도메인 엔티티
class Meeting {
  // 기본 정보
  final String title;
  final String description;
  final List<String> keywords;
  final List<String> imageUrls;

  // 일정 정보
  final DateTime startDate;
  final DateTime endDate;
  final List<ScheduleItem> schedules;

  // 장소 정보
  final String meetingPlace;
  final String meetingPlaceDetail;

  // 비용 및 참가 정보
  final List<String> equipments;
  final bool pickUpAvailable;
  final int capacity;
  final int pricePerPerson;
  final String costNote;

  // 질문지
  final String requiredQuestion;

  const Meeting({
    required this.title,
    required this.description,
    required this.keywords,
    required this.imageUrls,
    required this.startDate,
    required this.endDate,
    required this.schedules,
    required this.meetingPlace,
    required this.meetingPlaceDetail,
    required this.equipments,
    required this.pickUpAvailable,
    required this.capacity,
    required this.pricePerPerson,
    required this.costNote,
    required this.requiredQuestion,
  });

  Meeting copyWith({
    String? title,
    String? description,
    List<String>? keywords,
    List<String>? imageUrls,
    DateTime? startDate,
    DateTime? endDate,
    List<ScheduleItem>? schedules,
    String? meetingPlace,
    String? meetingPlaceDetail,
    List<String>? equipments,
    bool? pickUpAvailable,
    int? capacity,
    int? pricePerPerson,
    String? costNote,
    String? requiredQuestion,
  }) {
    return Meeting(
      title: title ?? this.title,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
      imageUrls: imageUrls ?? this.imageUrls,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      schedules: schedules ?? this.schedules,
      meetingPlace: meetingPlace ?? this.meetingPlace,
      meetingPlaceDetail: meetingPlaceDetail ?? this.meetingPlaceDetail,
      equipments: equipments ?? this.equipments,
      pickUpAvailable: pickUpAvailable ?? this.pickUpAvailable,
      capacity: capacity ?? this.capacity,
      pricePerPerson: pricePerPerson ?? this.pricePerPerson,
      costNote: costNote ?? this.costNote,
      requiredQuestion: requiredQuestion ?? this.requiredQuestion,
    );
  }
}

/// 일정 아이템
class ScheduleItem {
  final int minutes;
  final String title;

  const ScheduleItem({
    required this.minutes,
    required this.title,
  });

  ScheduleItem copyWith({
    int? minutes,
    String? title,
  }) {
    return ScheduleItem(
      minutes: minutes ?? this.minutes,
      title: title ?? this.title,
    );
  }
}
