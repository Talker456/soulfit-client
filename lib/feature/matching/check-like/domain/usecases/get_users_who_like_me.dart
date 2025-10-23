import '../entities/like_user.dart';
import '../repositories/check_like_repository.dart';

class GetUsersWhoLikeMe {
  final CheckLikeRepository repo;
  GetUsersWhoLikeMe(this.repo);
  Future<List<LikeUser>> call() =>
      repo.getUsersWhoLikeMe();
}
