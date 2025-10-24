import '../entities/ai_match.dart';
import '../repositories/check_like_repository.dart';

class GetAiMatch {
  final CheckLikeRepository repository;

  GetAiMatch(this.repository);

  Future<List<AiMatch>> call(List<int> candidateUserIds) async {
    return await repository.getAiMatch(candidateUserIds);
  }
}
