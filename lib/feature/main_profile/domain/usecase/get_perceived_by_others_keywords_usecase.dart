import 'package:dartz/dartz.dart';
import '../repository/main_profile_repository.dart';

class GetPerceivedByOthersKeywordsUseCase {
  final MainProfileRepository repository;

  GetPerceivedByOthersKeywordsUseCase(this.repository);

  Future<Either<Exception, List<String>>> call(String userId) {
    return repository.getPerceivedByOthersKeywords(userId);
  }
}
