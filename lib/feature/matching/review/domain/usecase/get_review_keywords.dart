import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';

class GetReviewKeywordsUseCase {
  final ReviewRepository _repository;
  GetReviewKeywordsUseCase(this._repository);

  Future<List<String>> call() => _repository.getReviewKeywords();
}
