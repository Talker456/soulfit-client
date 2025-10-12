import '../entities/like_user.dart';

abstract class CheckLikeRepository {
  Future<List<LikeUser>> getUsersWhoLikeMe({List<String> filters = const []});
  Future<List<LikeUser>> getUsersILike({
    List<String> filters = const [],
    String sub = 'viewed',
  });
}
