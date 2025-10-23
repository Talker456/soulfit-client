import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';
import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';

class GetMyReviewsUseCase {
  final ReviewRepository _repository;
  GetMyReviewsUseCase(this._repository);

  Future<List<Review>> call() => _repository.getMyReviews();
}
