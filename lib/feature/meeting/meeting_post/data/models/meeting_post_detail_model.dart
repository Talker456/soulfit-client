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
  final double meetingRating;
  final double hostRating;
  final String content;

  ReviewModel({
    required this.meetingRating,
    required this.hostRating,
    required this.content,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      meetingRating: (json['meetingRating'] ?? 0).toDouble(),
      hostRating: (json['hostRating'] ?? 0).toDouble(),
      content: json['content'] ?? json['text'] ?? '',
    );
  }

  Review toEntity() {
    return Review(
      meetingRating: meetingRating,
      hostRating: hostRating,
      content: content,
    );
  }
}

/// 참가자 통계 Model
class ParticipantStatsModel {
  final double malePercent;
  final double femalePercent;
  final Map<String, double> ageGroupDistribution;

  ParticipantStatsModel({
    required this.malePercent,
    required this.femalePercent,
    required this.ageGroupDistribution,
  });

  factory ParticipantStatsModel.fromJson(Map<String, dynamic> json) {
    Map<String, double> ageGroupDistribution = {};
    if (json['ageGroupDistribution'] != null &&
        json['ageGroupDistribution'] is Map) {
      final ageGroupsJson = json['ageGroupDistribution'] as Map<String, dynamic>;
      ageGroupsJson.forEach((key, value) {
        ageGroupDistribution[key] = (value ?? 0).toDouble();
      });
    }

    return ParticipantStatsModel(
      malePercent: (json['malePercent'] ?? 0).toDouble(),
      femalePercent: (json['femalePercent'] ?? 0).toDouble(),
      ageGroupDistribution: ageGroupDistribution,
    );
  }

  ParticipantStats toEntity() {
    return ParticipantStats(
      malePercent: malePercent.toInt(),
      femalePercent: femalePercent.toInt(),
      ageGroupDistribution: ageGroupDistribution,
    );
  }
}

/// 모임 상세 정보 Model
class MeetingPostDetailModel {
  final String id;
  final String title;
  final String hostName;
  final String? hostProfileImageUrl;
  final List<String> imageUrls;
  final String ddayBadge;
  final String communityButtonText;
  final String description;
  final List<String> keywords;
  final List<ScheduleItemModel> schedules;
  final String fullAddress;
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

  factory MeetingPostDetailModel.fromJson(Map<String, dynamic> json) {
    return MeetingPostDetailModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      hostName: json['hostName'] ?? json['host'] ?? '',
      hostProfileImageUrl: json['hostProfileImageUrl'],
      imageUrls: (json['imageUrls'] ?? json['images'] ?? [])
          .cast<String>()
          .toList(),
      ddayBadge: json['ddayBadge'] ?? json['dday'] ?? '',
      communityButtonText: json['communityButtonText'] ?? '커뮤니티 바로가기',
      description: json['description'] ?? '',
      keywords: (json['keywords'] ?? []).cast<String>().toList(),
      schedules: (json['schedules'] as List<dynamic>? ?? [])
          .map<ScheduleItemModel>((s) {
        if (s is String) {
          final parts = s.split(' - ');
          return ScheduleItemModel(
            timeRange: parts.isNotEmpty ? parts[0].trim() : '',
            title: parts.length > 1 ? parts[1].trim() : '',
          );
        } else if (s is Map<String, dynamic>) {
          return ScheduleItemModel.fromJson(s);
        }
        return ScheduleItemModel(timeRange: '', title: '');
      }).toList(),
      fullAddress: json['fullAddress'] ?? '',
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
      pricePerPerson: json['pricePerPerson'] ?? json['fee'] ?? 0,
    );
  }

  MeetingPostDetail toEntity() {
    return MeetingPostDetail(
      id: id,
      title: title,
      hostName: hostName,
      hostProfileImageUrl: hostProfileImageUrl,
      imageUrls: imageUrls,
      ddayBadge: ddayBadge,
      communityButtonText: communityButtonText,
      description: description,
      keywords: keywords,
      schedules: schedules.map((s) => s.toEntity()).toList(),
      fullAddress: fullAddress,
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
