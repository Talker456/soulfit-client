import 'package:dartz/dartz.dart';
import '../repository/main_profile_repository.dart';

class GetAIPredictedKeywordsUseCase {
  final MainProfileRepository repository;

  GetAIPredictedKeywordsUseCase(this.repository);

  Future<Either<Exception, List<String>>> call(String userId) {
    return repository.getAIPredictedKeywords(userId);
  }
}
