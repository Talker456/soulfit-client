import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';

class GetUserKeywordSummaryUseCase {
  final ReviewRepository _repository;
  GetUserKeywordSummaryUseCase(this._repository);

  Future<List<String>> call(int userId) => _repository.getUserKeywordSummary(userId);
}
