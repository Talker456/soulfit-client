import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../data/datasources/check_like_remote_ds.dart';
import '../../data/datasources/check_like_remote_ds_mock.dart';
import '../../data/repository_impl/check_like_repository_impl.dart';
import '../../data/models/like_user_model.dart';
import '../../domain/repositories/check_like_repository.dart';
import '../../domain/usecases/get_users_who_like_me.dart';
import '../../domain/usecases/get_users_i_like.dart';
import '../../ui/notifier/check_like_notifier.dart';

const _USE_MOCK = bool.fromEnvironment(
  'USE_MOCK_CHECK_LIKE',
  defaultValue: true,
);
const _base = String.fromEnvironment(
  'API_BASE',
  defaultValue: 'https://mock.api',
);

final _dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(baseUrl: _base)));

final _remoteProvider = Provider<CheckLikeRemoteDataSource>((ref) {
  if (_USE_MOCK) {
    final mock = CheckLikeRemoteDataSourceMock();
    return CheckLikeRemoteDataSourceAdapter.fromMock(mock);
  }
  return CheckLikeRemoteDataSource(ref.watch(_dioProvider));
});

class CheckLikeRemoteDataSourceAdapter extends CheckLikeRemoteDataSource {
  CheckLikeRemoteDataSourceAdapter._(super.dio) : super();
  late final CheckLikeRemoteDataSourceMock _mock;

  factory CheckLikeRemoteDataSourceAdapter.fromMock(
    CheckLikeRemoteDataSourceMock mock,
  ) {
    final adapter = CheckLikeRemoteDataSourceAdapter._(Dio());
    adapter._mock = mock;
    return adapter;
  }

  @override
  Future<List<LikeUserModel>> fetchUsersWhoLikeMe(List<String> filters) =>
      _mock.fetchUsersWhoLikeMe(filters);

  @override
  Future<List<LikeUserModel>> fetchUsersILike(
    List<String> filters, {
    String sub = 'viewed',
  }) => _mock.fetchUsersILike(filters, sub: sub);
}

final checkLikeRepoProvider = Provider<CheckLikeRepository>(
  (ref) => CheckLikeRepositoryImpl(ref.watch(_remoteProvider)),
);

final getUsersWhoLikeMeProvider = Provider(
  (ref) => GetUsersWhoLikeMe(ref.watch(checkLikeRepoProvider)),
);

final getUsersILikeProvider = Provider(
  (ref) => GetUsersILike(ref.watch(checkLikeRepoProvider)),
);

final checkLikeNotifierProvider =
    StateNotifierProvider.autoDispose<CheckLikeNotifier, CheckLikeState>((ref) {
      final likedMe = ref.watch(getUsersWhoLikeMeProvider);
      final iLike = ref.watch(getUsersILikeProvider);
      final n = CheckLikeNotifier(likedMe, iLike);
      Future.microtask(n.load);
      return n;
    });
