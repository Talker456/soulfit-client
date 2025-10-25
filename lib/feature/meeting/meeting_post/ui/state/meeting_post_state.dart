class MPSchedule {
  final String timeRange; // "11:00 ~ 11:30"
  final String title;
  MPSchedule(this.timeRange, this.title);
}

class MPReview {
  final double meetingRating;
  final double hostRating;
  final String content;
  MPReview(this.meetingRating, this.hostRating, this.content);
}

class MPStats {
  final int malePercent; // 0~100
  final int femalePercent;
  final Map<String, double> ageDistribution; // '30대': 100.0
  MPStats({
    required this.malePercent,
    required this.femalePercent,
    required this.ageDistribution,
  });
}

class MeetingPost {
  final String id;
  final String title;
  final String hostName;
  final String? hostProfileImageUrl;
  final List<String> images;
  final String ddayBadge; // "D-4"
  final String communityButtonText; // "커뮤니티 바로가기"
  final String description;
  final List<String> keywords;
  final List<MPSchedule> schedules;
  final String fullAddress; // 전체 주소
  final MPStats stats;
  final int reviewCount;
  final double reviewAvg;
  final String reviewSummary;
  final List<MPReview> reviews;
  final List<String> supplies;
  final int pricePerPerson;

  MeetingPost({
    required this.id,
    required this.title,
    required this.hostName,
    this.hostProfileImageUrl,
    required this.images,
    required this.ddayBadge,
    required this.communityButtonText,
    required this.description,
    required this.keywords,
    required this.schedules,
    required this.fullAddress,
    required this.stats,
    required this.reviewCount,
    required this.reviewAvg,
    required this.reviewSummary,
    required this.reviews,
    required this.supplies,
    required this.pricePerPerson,
  });
}

class MeetingPostState {
  final bool loading;
  final MeetingPost? data;
  final String? error;
  const MeetingPostState({this.loading = false, this.data, this.error});
  MeetingPostState copyWith({
    bool? loading,
    MeetingPost? data,
    String? error,
  }) => MeetingPostState(
    loading: loading ?? this.loading,
    data: data ?? this.data,
    error: error,
  );
}