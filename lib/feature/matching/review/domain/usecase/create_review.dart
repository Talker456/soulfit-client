import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';

class CreateReviewUseCase {
  final ReviewRepository _repository;
  CreateReviewUseCase(this._repository);

  Future<void> call({
    required int revieweeId,
    required int conversationRequestId,
    required String comment,
    required List<String> keywords,
  }) =>
      _repository.createReview(
        revieweeId: revieweeId,
        conversationRequestId: conversationRequestId,
        comment: comment,
        keywords: keywords,
      );
}
