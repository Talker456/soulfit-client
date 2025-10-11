import '../entities/like_user.dart';
import '../repositories/check_like_repository.dart';

class GetUsersILike {
  final CheckLikeRepository repo;
  GetUsersILike(this.repo);

  Future<List<LikeUser>> call({
    List<String> filters = const [],
    String sub = 'viewed',
  }) => repo.getUsersILike(filters: filters, sub: sub);
}
