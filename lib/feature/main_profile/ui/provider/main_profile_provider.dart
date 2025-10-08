import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/data/datasource/fake_main_profile_remote_data_source_impl.dart';

import '../../../matching/chat/conversation_req/ui/provider/conversation_provider.dart';
import '../../data/datasource/main_profile_remote_datasource.dart';
import '../../data/repository_impl/main_profile_repository_impl.dart';
import '../../domain/repository/main_profile_repository.dart';
import '../../domain/usecase/load_user_profile_screen_data_usecase.dart';
import '../notifier/main_profile_notifier.dart';
import '../state/main_profile_state.dart';

import 'package:soulfit_client/config/di/provider.dart';

import '../../data/datasource/main_profile_remote_datasource_impl.dart';

// Remote DataSource
final mainProfileRemoteDataSourceProvider =
    Provider<MainProfileRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeMainProfileRemoteDataSourceImpl();
  } else {
    return MainProfileRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      authLocalDataSource: ref.read(authLocalDataSourceProvider),
      base: BASE_URL,
    );
  }
});

// Repository
final mainProfileRepositoryProvider = Provider<MainProfileRepository>((ref) {
  final remote = ref.watch(mainProfileRemoteDataSourceProvider);
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
  final loadProfileUseCase = ref.watch(loadUserProfileScreenDataUseCaseProvider);
  final sendConversationUseCase = ref.watch(sendConversationRequestUseCaseProvider);
  return MainProfileNotifier(loadProfileUseCase, sendConversationUseCase);
});
