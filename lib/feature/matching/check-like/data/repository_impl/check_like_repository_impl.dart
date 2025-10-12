import '../../domain/entities/like_user.dart';
import '../../domain/repositories/check_like_repository.dart';
import '../datasources/check_like_remote_ds.dart';

class CheckLikeRepositoryImpl implements CheckLikeRepository {
  final CheckLikeRemoteDataSource remote;
  CheckLikeRepositoryImpl(this.remote);

  @override
  Future<List<LikeUser>> getUsersWhoLikeMe({
    List<String> filters = const [],
  }) async {
    final m = await remote.fetchUsersWhoLikeMe(filters);
    return m.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<LikeUser>> getUsersILike({
    List<String> filters = const [],
    String sub = 'viewed',
  }) async {
    final m = await remote.fetchUsersILike(filters, sub: sub);
    return m.map((e) => e.toEntity()).toList();
  }
}
