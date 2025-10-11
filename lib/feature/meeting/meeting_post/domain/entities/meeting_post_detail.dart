/// 모임 스케줄 항목
class ScheduleItem {
  final String timeRange; // "11:00 ~ 11:30"
  final String title;

  ScheduleItem({
    required this.timeRange,
    required this.title,
  });
}

/// 모임 리뷰
class Review {
  final String author;
  final double rating;
  final String content;

  Review({
    required this.author,
    required this.rating,
    required this.content,
  });
}

/// 참가자 통계
class ParticipantStats {
  final int malePercent; // 0~100
  final int femalePercent; // 0~100
  final Map<String, AgeGroupStats> ageGroups; // '20대': AgeGroupStats(40, 60)

  ParticipantStats({
    required this.malePercent,
    required this.femalePercent,
    required this.ageGroups,
  });
}

/// 연령대별 성별 통계
class AgeGroupStats {
  final int maleCount;
  final int femaleCount;

  AgeGroupStats({
    required this.maleCount,
    required this.femaleCount,
  });
}

/// 모임 상세 정보 Entity
class MeetingPostDetail {
  final String id;
  final String title;
  final String hostName;
  final List<String> imageUrls;
  final String ddayBadge; // "D-4"
  final String communityButtonText; // "커뮤니티 바로가기"
  final String description;
  final List<String> keywords;
  final List<ScheduleItem> schedules;
  final String meetPlaceAddress; // 모이는 장소
  final String venuePlaceAddress; // 진행 장소
  final ParticipantStats participantStats;
  final int reviewCount;
  final double reviewAvg;
  final String reviewSummary;
  final List<Review> reviews;
  final List<String> supplies; // 준비물
  final int pricePerPerson;

  MeetingPostDetail({
    required this.id,
    required this.title,
    required this.hostName,
    required this.imageUrls,
    required this.ddayBadge,
    required this.communityButtonText,
    required this.description,
    required this.keywords,
    required this.schedules,
    required this.meetPlaceAddress,
    required this.venuePlaceAddress,
    required this.participantStats,
    required this.reviewCount,
    required this.reviewAvg,
    required this.reviewSummary,
    required this.reviews,
    required this.supplies,
    required this.pricePerPerson,
  });
}
