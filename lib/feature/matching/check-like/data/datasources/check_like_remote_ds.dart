import '../models/like_user_model.dart';

abstract class CheckLikeRemoteDataSource {
  Future<List<LikeUserModel>> fetchUsersWhoLikeMe();

  Future<List<LikeUserModel>> fetchUsersILike();
}