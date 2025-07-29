import 'package:dartz/dartz.dart';
import '../repository/main_profile_repository.dart';

class CanViewDetailedValueAnalysisUseCase {
  final MainProfileRepository repository;

  CanViewDetailedValueAnalysisUseCase(this.repository);

  Future<Either<Exception, bool>> call({
    required String viewerUserId,
    required String targetUserId,
  }) {
    return repository.canViewDetailedValueAnalysis(
      viewerUserId: viewerUserId,
      targetUserId: targetUserId,
    );
  }
}
