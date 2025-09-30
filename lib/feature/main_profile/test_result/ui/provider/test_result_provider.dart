
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/main_profile/test_result/data/datasource/test_result_remote_datasource.dart';
import 'package:soulfit_client/feature/main_profile/test_result/data/datasource/test_result_remote_datasource_impl.dart';
import 'package:soulfit_client/feature/main_profile/test_result/data/repository_impl/test_result_repository_impl.dart';
import 'package:soulfit_client/feature/main_profile/test_result/domain/repository/test_result_repository.dart';
import 'package:soulfit_client/feature/main_profile/test_result/domain/usecase/get_test_result_usecase.dart';
import 'package:soulfit_client/feature/main_profile/test_result/ui/notifier/test_result_notifier.dart';
import 'package:soulfit_client/feature/main_profile/test_result/ui/state/test_result_state.dart';

// DataSource
final testResultRemoteDataSourceProvider = Provider<TestResultRemoteDataSource>((ref) {
  return TestResultRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
    base: BASE_URL,
  );
});

// Repository
final testResultRepositoryProvider = Provider<TestResultRepository>((ref) {
  final remoteDataSource = ref.watch(testResultRemoteDataSourceProvider);
  return TestResultRepositoryImpl(remoteDataSource);
});

// UseCase
final getTestResultUseCaseProvider = Provider<GetTestResultUseCase>((ref) {
  final repository = ref.watch(testResultRepositoryProvider);
  return GetTestResultUseCase(repository);
});

// Notifier
final testResultNotifierProvider = StateNotifierProvider.autoDispose<TestResultNotifier, TestResultState>((ref) {
  final useCase = ref.watch(getTestResultUseCaseProvider);
  return TestResultNotifier(useCase);
});
