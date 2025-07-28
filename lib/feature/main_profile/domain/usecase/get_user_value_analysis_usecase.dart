import 'package:dartz/dartz.dart';
import '../entity/user_value_analysis.dart';
import '../repository/main_profile_repository.dart';

class GetUserValueAnalysisUseCase {
  final MainProfileRepository repository;

  GetUserValueAnalysisUseCase(this.repository);

  Future<Either<Exception, UserValueAnalysis>> call(String userId) {
    return repository.getUserValueAnalysis(userId);
  }
}
