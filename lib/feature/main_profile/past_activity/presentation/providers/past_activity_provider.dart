import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/provider.dart';
import '../../data/datasources/past_activity_remote_datasource.dart';
import '../../data/datasources/past_activity_remote_datasource_impl.dart';
import '../../data/repository_impl/past_activity_repository_impl.dart';
import '../../domain/repositories/past_activity_repository.dart';
import '../../domain/usecases/get_participated_meetings_usecase.dart';
import '../../domain/usecases/get_application_meetings_usecase.dart';
import '../../domain/usecases/get_hosted_meetings_usecase.dart';
import '../../domain/usecases/get_ai_summary_usecase.dart';

// DataSource Provider
final pastActivityRemoteDataSourceProvider =
    Provider<PastActivityRemoteDataSource>((ref) {
  return PastActivityRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    source: ref.read(authLocalDataSourceProvider),
    baseUrl: BASE_URL,
  );
});

// Repository Provider
final pastActivityRepositoryProvider = Provider<PastActivityRepository>((ref) {
  final remoteDataSource = ref.watch(pastActivityRemoteDataSourceProvider);
  return PastActivityRepositoryImpl(remoteDataSource: remoteDataSource);
});

// UseCase Providers
final getParticipatedMeetingsUseCaseProvider =
    Provider<GetParticipatedMeetingsUseCase>((ref) {
  final repository = ref.watch(pastActivityRepositoryProvider);
  return GetParticipatedMeetingsUseCase(repository: repository);
});

final getApplicationMeetingsUseCaseProvider =
    Provider<GetApplicationMeetingsUseCase>((ref) {
  final repository = ref.watch(pastActivityRepositoryProvider);
  return GetApplicationMeetingsUseCase(repository: repository);
});

final getHostedMeetingsUseCaseProvider =
    Provider<GetHostedMeetingsUseCase>((ref) {
  final repository = ref.watch(pastActivityRepositoryProvider);
  return GetHostedMeetingsUseCase(repository: repository);
});

final getAiSummaryUseCaseProvider = Provider<GetAiSummaryUseCase>((ref) {
  final repository = ref.watch(pastActivityRepositoryProvider);
  return GetAiSummaryUseCase(repository: repository);
});
