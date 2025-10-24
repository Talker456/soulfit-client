import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';
import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';

class GetReviewsForUserUseCase {
  final ReviewRepository _repository;
  GetReviewsForUserUseCase(this._repository);

  Future<List<Review>> call(int userId) => _repository.getReviewsForUser(userId);
}
