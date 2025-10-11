import '../../domain/entities/review.dart';

/// 리뷰 Model
class ReviewModel {
  final String id;
  final String authorName;
  final String authorImageUrl;
  final double rating;
  final String date;
  final String content;
  final int reviewCount;
  final List<String> keywords;

  ReviewModel({
    required this.id,
    required this.authorName,
    required this.authorImageUrl,
    required this.rating,
    required this.date,
    required this.content,
    required this.reviewCount,
    this.keywords = const [],
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    return ReviewModel(
      id: json['id']?.toString() ?? '',
      authorName: json['authorName'] ?? json['author'] ?? '',
      authorImageUrl: json['authorImageUrl'] ?? json['authorImage'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      date: json['date'] ?? json['createdAt'] ?? '',
      content: json['content'] ?? json['text'] ?? '',
      reviewCount: json['reviewCount'] ?? json['authorReviewCount'] ?? 0,
      keywords: (json['keywords'] ?? []).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'authorName': authorName,
      'authorImageUrl': authorImageUrl,
      'rating': rating,
      'date': date,
      'content': content,
      'reviewCount': reviewCount,
      'keywords': keywords,
    };
  }

  Review toEntity() {
    return Review(
      id: id,
      authorName: authorName,
      authorImageUrl: authorImageUrl,
      rating: rating,
      date: date,
      content: content,
      reviewCount: reviewCount,
      keywords: keywords,
    );
  }
}

/// 평점 통계 Model
class ReviewStatsModel {
  final double groupRating;
  final double hostRating;
  final int totalReviews;

  ReviewStatsModel({
    required this.groupRating,
    required this.hostRating,
    required this.totalReviews,
  });

  factory ReviewStatsModel.fromJson(Map<String, dynamic> json) {
    // TODO: 백엔드 응답 형식 확인 필요
    return ReviewStatsModel(
      groupRating: (json['groupRating'] ?? json['meetingRating'] ?? 0).toDouble(),
      hostRating: (json['hostRating'] ?? 0).toDouble(),
      totalReviews: json['totalReviews'] ?? json['reviewCount'] ?? 0,
    );
  }

  ReviewStats toEntity() {
    return ReviewStats(
      groupRating: groupRating,
      hostRating: hostRating,
      totalReviews: totalReviews,
    );
  }
}

/// 리뷰 작성 요청 Model
class CreateReviewRequestModel {
  final String meetingId;
  final double rating;
  final String content;
  final List<String> keywords;

  CreateReviewRequestModel({
    required this.meetingId,
    required this.rating,
    required this.content,
    this.keywords = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'meetingId': meetingId,
      'rating': rating,
      'content': content,
      'keywords': keywords,
    };
  }

  factory CreateReviewRequestModel.fromEntity(CreateReviewRequest entity) {
    return CreateReviewRequestModel(
      meetingId: entity.meetingId,
      rating: entity.rating,
      content: entity.content,
      keywords: entity.keywords,
    );
  }
}
