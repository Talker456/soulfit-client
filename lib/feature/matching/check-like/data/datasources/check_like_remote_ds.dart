import '../models/ai_match_response_model.dart';
import '../models/like_user_model.dart';

abstract class CheckLikeRemoteDataSource {
  Future<List<LikeUserModel>> fetchUsersWhoLikeMe();

  Future<List<LikeUserModel>> fetchUsersILike();

  Future<List<AiMatchResponseModel>> getAiMatch(List<int> candidateUserIds);
}