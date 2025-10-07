import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/di/provider.dart';
import '../../data/datasources/fake_filter_remote_datasource.dart';
import '../../data/datasources/filter_local_datasource.dart';
import '../../data/datasources/filter_local_datasource_impl.dart';
import '../../data/datasources/filter_remote_datasource.dart';
import '../../data/datasources/filter_remote_datasource_impl.dart';
import '../../data/repository_impl/filter_repository_impl.dart';
import '../../domain/repositories/filter_repository.dart';
import '../../domain/usecases/clear_saved_filter_usecase.dart';
import '../../domain/usecases/get_filtered_users_usecase.dart';
import '../../domain/usecases/get_saved_filter_usecase.dart';
import '../../domain/usecases/save_filter_usecase.dart';
import '../riverpod/dating_filter_riverpod.dart';

final datingFilterProvider = StateNotifierProvider<DatingFilterNotifier, DatingFilterState>(
      (ref) => DatingFilterNotifier(
    getSavedFilterUseCase: ref.read(getSavedFilterUseCaseProvider),
    saveFilterUseCase: ref.read(saveFilterUseCaseProvider),
    clearSavedFilterUseCase: ref.read(clearSavedFilterUseCaseProvider),
    getFilteredUsersUseCase: ref.read(getFilteredUsersUseCaseProvider),
  ),
);

final filterRemoteDataSourceProvider = Provider<FilterRemoteDataSource>((ref) {
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

final filterLocalDataSourceProvider = Provider<FilterLocalDataSource>((ref) {
  return FilterLocalDataSourceImpl(
    storage: ref.read(secureStorageProvider),
  );
});

final filterRepositoryProvider = Provider<FilterRepository>((ref) {
  final remoteDataSource = ref.watch(filterRemoteDataSourceProvider);
  final localDataSource = ref.watch(filterLocalDataSourceProvider);
  return FilterRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final getFilteredUsersUseCaseProvider = Provider<GetFilteredUsersUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return GetFilteredUsersUseCase(repository);
});

final saveFilterUseCaseProvider = Provider<SaveFilterUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return SaveFilterUseCase(repository);
});

final getSavedFilterUseCaseProvider = Provider<GetSavedFilterUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return GetSavedFilterUseCase(repository);
});

final clearSavedFilterUseCaseProvider = Provider<ClearSavedFilterUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return ClearSavedFilterUseCase(repository);
});
