import '../../domain/entities/like_user.dart';
import '../../domain/repositories/check_like_repository.dart';
import '../datasources/check_like_remote_ds.dart';

class CheckLikeRepositoryImpl implements CheckLikeRepository {
  final CheckLikeRemoteDataSource remote;
  CheckLikeRepositoryImpl(this.remote);

  @override
  Future<List<LikeUser>> getUsersWhoLikeMe() async {
    final m = await remote.fetchUsersWhoLikeMe();
    return m.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<LikeUser>> getUsersILike() async {
    final m = await remote.fetchUsersILike();
    return m.map((e) => e.toEntity()).toList();
  }
}
