
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/matching/filter/data/datasources/fake_filter_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/filter/data/datasources/filter_local_datasource.dart';
import 'package:soulfit_client/feature/matching/filter/data/datasources/filter_local_datasource_impl.dart';
import 'package:soulfit_client/feature/matching/filter/data/datasources/filter_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/filter/data/datasources/filter_remote_datasource_impl.dart';
import 'package:soulfit_client/feature/matching/filter/data/repository_impl/filter_repository_impl.dart';
import 'package:soulfit_client/feature/matching/filter/domain/repositories/filter_repository.dart';
import 'package:soulfit_client/feature/matching/filter/domain/usecases/get_saved_filter_usecase.dart';
import 'package:soulfit_client/feature/matching/main/data/datasources/dating_main_fake_datasource.dart';
import 'package:soulfit_client/feature/matching/main/data/datasources/dating_main_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/main/data/datasources/dating_main_remote_datasource_impl.dart';
import 'package:soulfit_client/feature/matching/main/data/repositories/dating_main_repository_impl.dart';
import 'package:soulfit_client/feature/matching/main/domain/repositories/dating_main_repository.dart';
import 'package:soulfit_client/feature/matching/main/domain/usecases/get_recommended_users_usecase.dart';
import 'package:soulfit_client/feature/matching/recommendation/data/datasource/swipe_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/recommendation/data/datasource/swipe_remote_datasource_impl.dart';
import 'package:soulfit_client/feature/matching/recommendation/data/repository_impl/swipe_repository_impl.dart';
import 'package:soulfit_client/feature/matching/recommendation/domain/repository/swipe_repository.dart';
import 'package:soulfit_client/feature/matching/recommendation/domain/usecase/send_swipe_usecase.dart';
import 'package:soulfit_client/feature/matching/recommendation/presentation/notifier/recommended_user_notifier.dart';
import 'package:soulfit_client/feature/matching/recommendation/presentation/state/recommended_user_state.dart';

// --- GetRecommendedUsers Providers ---
final _datingMainRemoteDataSourceProvider = Provider<DatingMainRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return DatingMainFakeDataSource();
  } else {
    return DatingMainRemoteDataSourceImpl(
      client: ref.watch(httpClientProvider),
      authSource: ref.watch(authLocalDataSourceProvider),
      baseUrl: BASE_URL,
    );
  }
});

final _datingMainRepositoryProvider = Provider<DatingMainRepository>((ref) {
  final remoteDataSource = ref.watch(_datingMainRemoteDataSourceProvider);
  return DatingMainRepositoryImpl(remoteDataSource: remoteDataSource);
});

final getRecommendedUsersUseCaseProvider = Provider<GetRecommendedUsersUseCase>((ref) {
  final repository = ref.watch(_datingMainRepositoryProvider);
  return GetRecommendedUsersUseCase(repository);
});

// --- SendSwipe Providers ---
final swipeRemoteDataSourceProvider = Provider<SwipeRemoteDataSource>((ref) {
  return SwipeRemoteDataSourceImpl(
    client: ref.watch(httpClientProvider),
    authLocalDataSource: ref.watch(authLocalDataSourceProvider),
  );
});

final swipeRepositoryProvider = Provider<SwipeRepository>((ref) {
  return SwipeRepositoryImpl(
    remoteDataSource: ref.watch(swipeRemoteDataSourceProvider),
  );
});

final sendSwipeUseCaseProvider = Provider<SendSwipeUseCase>((ref) {
  return SendSwipeUseCase(ref.watch(swipeRepositoryProvider));
});

// --- GetSavedFilter Providers ---
final _filterRemoteDataSourceProvider = Provider<FilterRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeFilterRemoteDataSource();
  } else {
    return FilterRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      authSource: ref.read(authLocalDataSourceProvider),
      baseUrl: BASE_URL,
    );
  }
});

final _filterLocalDataSourceProvider = Provider<FilterLocalDataSource>((ref) {
  return FilterLocalDataSourceImpl(storage: ref.read(secureStorageProvider));
});

final _filterRepositoryProvider = Provider<FilterRepository>((ref) {
  return FilterRepositoryImpl(
    remoteDataSource: ref.watch(_filterRemoteDataSourceProvider),
    localDataSource: ref.watch(_filterLocalDataSourceProvider),
  );
});

final getSavedFilterUseCaseProvider = Provider<GetSavedFilterUseCase>((ref) {
  return GetSavedFilterUseCase(ref.watch(_filterRepositoryProvider));
});


// --- Presentation Layer Provider ---
final recommendedUserNotifierProvider = StateNotifierProvider.autoDispose<
    RecommendedUserNotifier, RecommendedUserState>((ref) {
  return RecommendedUserNotifier(
    getRecommendedUsersUseCase: ref.watch(getRecommendedUsersUseCaseProvider),
    sendSwipeUseCase: ref.watch(sendSwipeUseCaseProvider),
    getSavedFilterUseCase: ref.watch(getSavedFilterUseCaseProvider),
  );
});
