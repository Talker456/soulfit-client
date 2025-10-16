import '../entities/like_user.dart';
import '../repositories/check_like_repository.dart';

class GetUsersILike {
  final CheckLikeRepository repo;
  GetUsersILike(this.repo);

  Future<List<LikeUser>> call() => repo.getUsersILike();
}
