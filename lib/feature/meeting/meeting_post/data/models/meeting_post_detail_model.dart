import '../../domain/entities/meeting_post_detail.dart';

/// 스케줄 항목 Model
class ScheduleItemModel {
  final String timeRange;
  final String title;

  ScheduleItemModel({
    required this.timeRange,
    required this.title,
  });

  factory ScheduleItemModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    return ScheduleItemModel(
      timeRange: json['timeRange'] ?? json['time'] ?? '',
      title: json['title'] ?? '',
    );
  }

  ScheduleItem toEntity() {
    return ScheduleItem(
      timeRange: timeRange,
      title: title,
    );
  }
}

/// 리뷰 Model
class ReviewModel {
  final String author;
  final double rating;
  final String content;

  ReviewModel({
    required this.author,
    required this.rating,
    required this.content,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    return ReviewModel(
      author: json['author'] ?? json['authorName'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      content: json['content'] ?? json['text'] ?? '',
    );
  }

  Review toEntity() {
    return Review(
      author: author,
      rating: rating,
      content: content,
    );
  }
}

/// 연령대별 성별 통계 Model
class AgeGroupStatsModel {
  final int maleCount;
  final int femaleCount;

  AgeGroupStatsModel({
    required this.maleCount,
    required this.femaleCount,
  });

  factory AgeGroupStatsModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    return AgeGroupStatsModel(
      maleCount: json['maleCount'] ?? json['male'] ?? 0,
      femaleCount: json['femaleCount'] ?? json['female'] ?? 0,
    );
  }

  AgeGroupStats toEntity() {
    return AgeGroupStats(
      maleCount: maleCount,
      femaleCount: femaleCount,
    );
  }
}

/// 참가자 통계 Model
class ParticipantStatsModel {
  final int malePercent;
  final int femalePercent;
  final Map<String, AgeGroupStatsModel> ageGroups;

  ParticipantStatsModel({
    required this.malePercent,
    required this.femalePercent,
    required this.ageGroups,
  });

  factory ParticipantStatsModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    Map<String, AgeGroupStatsModel> ageGroups = {};

    if (json['ageGroups'] != null && json['ageGroups'] is Map) {
      final ageGroupsJson = json['ageGroups'] as Map<String, dynamic>;
      ageGroupsJson.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          ageGroups[key] = AgeGroupStatsModel.fromJson(value);
        }
      });
    }

    return ParticipantStatsModel(
      malePercent: json['malePercent'] ?? json['malePercentage'] ?? 0,
      femalePercent: json['femalePercent'] ?? json['femalePercentage'] ?? 0,
      ageGroups: ageGroups,
    );
  }

  ParticipantStats toEntity() {
    return ParticipantStats(
      malePercent: malePercent,
      femalePercent: femalePercent,
      ageGroups: ageGroups.map((key, value) => MapEntry(key, value.toEntity())),
    );
  }
}

/// 모임 상세 정보 Model
class MeetingPostDetailModel {
  final String id;
  final String title;
  final String hostName;
  final List<String> imageUrls;
  final String ddayBadge;
  final String communityButtonText;
  final String description;
  final List<String> keywords;
  final List<ScheduleItemModel> schedules;
  final String meetPlaceAddress;
  final String venuePlaceAddress;
  final ParticipantStatsModel participantStats;
  final int reviewCount;
  final double reviewAvg;
  final String reviewSummary;
  final List<ReviewModel> reviews;
  final List<String> supplies;
  final int pricePerPerson;

  MeetingPostDetailModel({
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

  factory MeetingPostDetailModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    return MeetingPostDetailModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      hostName: json['hostName'] ?? json['host'] ?? '',
      imageUrls: (json['imageUrls'] ?? json['images'] ?? [])
          .cast<String>()
          .toList(),
      ddayBadge: json['ddayBadge'] ?? json['dday'] ?? '',
      communityButtonText: json['communityButtonText'] ?? '커뮤니티 바로가기',
      description: json['description'] ?? '',
      keywords: (json['keywords'] ?? []).cast<String>().toList(),
      schedules: (json['schedules'] ?? [])
          .map<ScheduleItemModel>((s) => ScheduleItemModel.fromJson(s))
          .toList(),
      meetPlaceAddress: json['meetPlaceAddress'] ?? json['meetingPlace'] ?? '',
      venuePlaceAddress: json['venuePlaceAddress'] ?? json['venue'] ?? '',
      participantStats: ParticipantStatsModel.fromJson(
        json['participantStats'] ?? json['stats'] ?? {},
      ),
      reviewCount: json['reviewCount'] ?? 0,
      reviewAvg: (json['reviewAvg'] ?? json['averageRating'] ?? 0).toDouble(),
      reviewSummary: json['reviewSummary'] ?? '',
      reviews: (json['reviews'] ?? [])
          .map<ReviewModel>((r) => ReviewModel.fromJson(r))
          .toList(),
      supplies: (json['supplies'] ?? []).cast<String>().toList(),
      pricePerPerson: json['pricePerPerson'] ?? json['price'] ?? 0,
    );
  }

  MeetingPostDetail toEntity() {
    return MeetingPostDetail(
      id: id,
      title: title,
      hostName: hostName,
      imageUrls: imageUrls,
      ddayBadge: ddayBadge,
      communityButtonText: communityButtonText,
      description: description,
      keywords: keywords,
      schedules: schedules.map((s) => s.toEntity()).toList(),
      meetPlaceAddress: meetPlaceAddress,
      venuePlaceAddress: venuePlaceAddress,
      participantStats: participantStats.toEntity(),
      reviewCount: reviewCount,
      reviewAvg: reviewAvg,
      reviewSummary: reviewSummary,
      reviews: reviews.map((r) => r.toEntity()).toList(),
      supplies: supplies,
      pricePerPerson: pricePerPerson,
    );
  }
}
