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
  final double meetingRating;
  final double hostRating;
  final String content;

  Review({
    required this.meetingRating,
    required this.hostRating,
    required this.content,
  });
}

/// 참가자 통계
class ParticipantStats {
  final int malePercent; // 0~100
  final int femalePercent; // 0~100
  final Map<String, double> ageGroupDistribution; // '30대': 100.0

  ParticipantStats({
    required this.malePercent,
    required this.femalePercent,
    required this.ageGroupDistribution,
  });
}

// AgeGroupStats 클래스는 새로운 응답 구조에서 사용되지 않으므로 삭제됨

/// 모임 상세 정보 Entity
class MeetingPostDetail {
  final String id;
  final String title;
  final String hostName;
  final String? hostProfileImageUrl;
  final List<String> imageUrls;
  final String ddayBadge; // "D-4"
  final String communityButtonText; // "커뮤니티 바로가기"
  final String description;
  final List<String> keywords;
  final List<ScheduleItem> schedules;
  final String fullAddress; // 전체 주소
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
    this.hostProfileImageUrl,
    required this.imageUrls,
    required this.ddayBadge,
    required this.communityButtonText,
    required this.description,
    required this.keywords,
    required this.schedules,
    required this.fullAddress,
    required this.participantStats,
    required this.reviewCount,
    required this.reviewAvg,
    required this.reviewSummary,
    required this.reviews,
    required this.supplies,
    required this.pricePerPerson,
  });
}