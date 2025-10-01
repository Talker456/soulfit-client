// User Report Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/provider.dart';
import '../../data/datasources/fake_user_report_remote_datasource.dart';
import '../../data/datasources/user_report_api.dart';
import '../../data/repository_impl/user_report_repository_impl.dart';
import '../../domain/repositories/user_report_repository.dart';
import '../../domain/usecases/report_user_usecase.dart';

final userReportRemoteDataSourceProvider = Provider<UserReportRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeUserReportRemoteDataSource();
  } else {
    return UserReportRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      source: ref.read(authLocalDataSourceProvider),
      baseUrl: BASE_URL,
    );
  }
});

final userReportRepositoryProvider = Provider<UserReportRepository>((ref) {
  final remoteDataSource = ref.watch(userReportRemoteDataSourceProvider);
  return UserReportRepositoryImpl(remoteDataSource: remoteDataSource);
});

final reportUserUseCaseProvider = Provider<ReportUserUseCase>((ref) {
  final repository = ref.watch(userReportRepositoryProvider);
  return ReportUserUseCase(repository: repository);
});