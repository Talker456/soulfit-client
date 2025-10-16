import '../entities/like_user.dart';

abstract class CheckLikeRepository {
  Future<List<LikeUser>> getUsersWhoLikeMe();
  Future<List<LikeUser>> getUsersILike();
}
