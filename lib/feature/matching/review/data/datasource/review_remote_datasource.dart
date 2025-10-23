
import 'package:soulfit_client/feature/matching/review/data/model/create_review_request_dto.dart';
import 'package:soulfit_client/feature/matching/review/data/model/review_response_dto.dart';

abstract class ReviewRemoteDataSource {
  Future<ReviewResponseDto> createReview(CreateReviewRequestDto request);
  Future<List<ReviewResponseDto>> getReviewsForUser(int userId);
  Future<List<ReviewResponseDto>> getMyReviews();
  Future<List<String>> getReviewKeywords();
  Future<List<String>> getUserKeywordSummary(int userId);
}
