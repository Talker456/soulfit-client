import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http; // Use http package
import 'package:soulfit_client/config/di/provider.dart'; // Assuming this provides AuthLocalDataSource

import '../../data/datasources/check_like_remote_ds.dart';
import '../../data/datasources/check_like_remote_ds_impl.dart';
import '../../data/datasources/check_like_remote_ds_mock.dart';
import '../../data/repository_impl/check_like_repository_impl.dart';
import '../../domain/repositories/check_like_repository.dart';
import '../../domain/usecases/get_ai_match.dart';
import '../../domain/usecases/get_users_who_like_me.dart';
import '../../domain/usecases/get_users_i_like.dart';
import '../../ui/notifier/check_like_notifier.dart';

const _base = String.fromEnvironment(
  'API_BASE',
  defaultValue: 'localhost', // Changed default to localhost as per API docs
);

final _httpClientProvider = Provider<http.Client>((ref) => http.Client()); // Provide http client

final _remoteProvider = Provider<CheckLikeRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return CheckLikeRemoteDataSourceMockImpl();
  }
  return CheckLikeRemoteDataSourceImpl(
    client: ref.watch(_httpClientProvider),
    authLocalDataSource: ref.watch(authLocalDataSourceProvider), // Assuming this provider exists
    base: _base,
  );
});

final checkLikeRepoProvider = Provider<CheckLikeRepository>(
  (ref) => CheckLikeRepositoryImpl(ref.watch(_remoteProvider)),
);

final getUsersWhoLikeMeProvider = Provider(
  (ref) => GetUsersWhoLikeMe(ref.watch(checkLikeRepoProvider)),
);

final getUsersILikeProvider = Provider(
  (ref) => GetUsersILike(ref.watch(checkLikeRepoProvider)),
);

final getAiMatchProvider = Provider(
  (ref) => GetAiMatch(ref.watch(checkLikeRepoProvider)),
);

final checkLikeNotifierProvider =
    StateNotifierProvider.autoDispose<CheckLikeNotifier, CheckLikeState>((ref) {
      final likedMe = ref.watch(getUsersWhoLikeMeProvider);
      final iLike = ref.watch(getUsersILikeProvider);
      final getAiMatch = ref.watch(getAiMatchProvider);
      final n = CheckLikeNotifier(likedMe, iLike, getAiMatch);
      Future.microtask(n.load);
      return n;
    });
