
import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';

abstract class ReviewRepository {
  // 1. 리뷰 생성
  Future<void> createReview({
    required int revieweeId,
    required int conversationRequestId,
    required String comment,
    required List<String> keywords,
  });

  // 2. 특정 사용자가 받은 리뷰 목록 조회
  Future<List<Review>> getReviewsForUser(int userId);

  // 3. 내가 작성한 리뷰 목록 조회
  Future<List<Review>> getMyReviews();

  // 4. 선택 가능한 모든 리뷰 키워드 목록 조회
  Future<List<String>> getReviewKeywords();

  // 5. 특정 사용자의 상위 리뷰 키워드 요약 조회
  Future<List<String>> getUserKeywordSummary(int userId);
}
