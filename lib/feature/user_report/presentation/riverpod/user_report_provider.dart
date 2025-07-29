// lib/feature/user_report/presentation/riverpod/user_report_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_report_request.dart';
import '../../domain/usecases/report_user_usecase.dart';
import '../../data/repository_impl/user_report_repository_impl.dart';
import '../../data/datasources/user_report_api.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final userReportApiProvider = Provider<UserReportApi>((ref) {
  final dio = ref.read(dioProvider);
  return UserReportApi(dio: dio);
});

final userReportRepositoryProvider = Provider<UserReportRepositoryImpl>((ref) {
  final api = ref.read(userReportApiProvider);
  return UserReportRepositoryImpl(remoteDataSource: api);
});

final reportUserUseCaseProvider = Provider<ReportUserUseCase>((ref) {
  final repository = ref.read(userReportRepositoryProvider);
  return ReportUserUseCase(repository: repository);
});

final userReportProvider = AsyncNotifierProvider<UserReportNotifier, void>(
  UserReportNotifier.new,
);

class UserReportNotifier extends AsyncNotifier<void> {
  late final ReportUserUseCase _useCase;

  @override
  Future<void> build() async {
    _useCase = ref.read(reportUserUseCaseProvider);
  }

  Future<void> reportUser({
    required String reporterUserId,
    required String reportedUserId,
    required String reason,
  }) async {
    state = const AsyncLoading();

    try {
      final request = UserReportRequest(
        reporterUserId: reporterUserId,
        reportedUserId: reportedUserId,
        reason: reason,
      );
      await _useCase.call(request);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
