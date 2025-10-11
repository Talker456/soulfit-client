/// 리뷰 Entity
class Review {
  final String id;
  final String authorName;
  final String authorImageUrl;
  final double rating;
  final String date;
  final String content;
  final int reviewCount; // 해당 유저가 작성한 리뷰 수
  final List<String> keywords; // 키워드 리스트

  Review({
    required this.id,
    required this.authorName,
    required this.authorImageUrl,
    required this.rating,
    required this.date,
    required this.content,
    required this.reviewCount,
    this.keywords = const [],
  });
}

/// 평점 통계 Entity
class ReviewStats {
  final double groupRating; // 모임 평점
  final double hostRating; // 호스트 평점
  final int totalReviews; // 전체 리뷰 수

  ReviewStats({
    required this.groupRating,
    required this.hostRating,
    required this.totalReviews,
  });
}

/// 리뷰 작성 요청 Entity
class CreateReviewRequest {
  final String meetingId;
  final double rating;
  final String content;
  final List<String> keywords;

  CreateReviewRequest({
    required this.meetingId,
    required this.rating,
    required this.content,
    this.keywords = const [],
  });
}
