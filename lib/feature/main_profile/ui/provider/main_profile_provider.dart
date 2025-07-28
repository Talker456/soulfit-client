import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/main_profile_remote_datasource.dart';
import '../../data/repository_impl/main_profile_repository_impl.dart';
import '../../domain/repository/main_profile_repository.dart';
import '../../domain/usecase/load_user_profile_screen_data_usecase.dart';
import '../notifier/main_profile_notifier.dart';
import '../state/main_profile_state.dart';

import '../../data/datasource/fake_main_profile_remote_data_source_impl.dart';

// Remote DataSource (임시로 Fake 사용)
final _remoteDataSourceProvider = Provider<MainProfileRemoteDataSource>((ref) {
  return FakeMainProfileRemoteDataSourceImpl();
});

// Repository
final mainProfileRepositoryProvider = Provider<MainProfileRepository>((ref) {
  final remote = ref.watch(_remoteDataSourceProvider);
  return MainProfileRepositoryImpl(remote);
});

// UseCase
final loadUserProfileScreenDataUseCaseProvider =
Provider<LoadUserProfileScreenDataUseCase>((ref) {
  final repo = ref.watch(mainProfileRepositoryProvider);
  return LoadUserProfileScreenDataUseCase(repo);
});

// Notifier
final mainProfileNotifierProvider =
StateNotifierProvider<MainProfileNotifier, MainProfileState>((ref) {
  final useCase = ref.watch(loadUserProfileScreenDataUseCaseProvider);
  return MainProfileNotifier(useCase);
});
