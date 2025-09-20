
import 'package:soulfit_client/feature/matching/review/data/datasource/review_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/review/data/model/create_review_request_dto.dart';
import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';
import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createReview({
    required int revieweeId,
    required int conversationRequestId,
    required String comment,
    required List<String> keywords,
  }) async {
    // In a real app, you might have a domain entity for this request
    // and convert it to a DTO here.
    final requestDto = CreateReviewRequestDto(
      revieweeId: revieweeId,
      conversationRequestId: conversationRequestId,
      comment: comment,
      keywords: keywords,
    );
    // The DTO extends the domain entity, so we can return it directly.
    // For create, we return void as per the domain layer definition.
    await remoteDataSource.createReview(requestDto);
  }

  @override
  Future<List<Review>> getReviewsForUser(int userId) async {
    // The DTO extends the domain entity, so we can return the list directly.
    return remoteDataSource.getReviewsForUser(userId);
  }

  @override
  Future<List<Review>> getMyReviews() async {
    // The DTO extends the domain entity, so we can return the list directly.
    return remoteDataSource.getMyReviews();
  }

  @override
  Future<List<String>> getReviewKeywords() async {
    return remoteDataSource.getReviewKeywords();
  }

  @override
  Future<List<String>> getUserKeywordSummary(int userId) async {
    return remoteDataSource.getUserKeywordSummary(userId);
  }
}
