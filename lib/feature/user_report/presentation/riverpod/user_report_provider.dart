// lib/feature/user_report/presentation/riverpod/user_report_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_report_request.dart';
import '../../../../config/di/provider.dart';

final userReportProvider = AsyncNotifierProvider<UserReportNotifier, void>(
  UserReportNotifier.new,
);

class UserReportNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // Provider에서 useCase를 가져올 준비
  }

  Future<void> reportUser({
    required String reporterUserId,
    required String reportedUserId,
    required String reason,
  }) async {
    state = const AsyncLoading();

    try {
      final useCase = ref.read(reportUserUseCaseProvider);
      final request = UserReportRequest(
        reporterUserId: reporterUserId,
        reportedUserId: reportedUserId,
        reason: reason,
      );
      await useCase.call(request);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
