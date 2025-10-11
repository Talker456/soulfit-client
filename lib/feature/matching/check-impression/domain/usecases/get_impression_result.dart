import '../entities/impression_result.dart';
import '../repositories/impression_repository.dart';

class GetImpressionResult {
  final ImpressionRepository repo;
  GetImpressionResult(this.repo);

  Future<ImpressionResult> call(String targetUserId) {
    return repo.getResult(targetUserId);
  }
}
