import '../entities/ai_match.dart';
import '../entities/like_user.dart';

abstract class CheckLikeRepository {
  Future<List<LikeUser>> getUsersWhoLikeMe();
  Future<List<LikeUser>> getUsersILike();
  Future<List<AiMatch>> getAiMatch(List<int> candidateUserIds);
}
