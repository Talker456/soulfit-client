import '../entities/review.dart';

/// 리뷰 Repository Interface
abstract class ReviewRepository {
  /// 모임 리뷰 목록 조회
  /// [meetingId] 조회할 모임 ID
  /// Returns: 리뷰 목록
  Future<List<Review>> getReviews(String meetingId);

  /// 모임 평점 통계 조회
  /// [meetingId] 조회할 모임 ID
  /// Returns: 평점 통계
  Future<ReviewStats> getReviewStats(String meetingId);

  /// 리뷰 작성
  /// [request] 리뷰 작성 요청
  /// Returns: 생성된 리뷰 ID
  Future<String> createReview(CreateReviewRequest request);
}
