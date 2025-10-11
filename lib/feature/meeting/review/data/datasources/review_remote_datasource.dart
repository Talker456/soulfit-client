import '../models/review_model.dart';

/// 리뷰 Remote DataSource Interface
abstract class ReviewRemoteDataSource {
  /// 리뷰 목록 조회
  /// [meetingId] 조회할 모임 ID
  /// Returns: 리뷰 목록 Model
  Future<List<ReviewModel>> getReviews(String meetingId);

  /// 평점 통계 조회
  /// [meetingId] 조회할 모임 ID
  /// Returns: 평점 통계 Model
  Future<ReviewStatsModel> getReviewStats(String meetingId);

  /// 리뷰 작성
  /// [request] 리뷰 작성 요청 Model
  /// Returns: 생성된 리뷰 ID
  Future<String> createReview(CreateReviewRequestModel request);
}
