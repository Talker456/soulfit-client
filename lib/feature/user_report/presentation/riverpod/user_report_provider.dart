import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/provider.dart';
import '../provider/user_report_provider.dart';

final userReportProvider = AsyncNotifierProvider<UserReportNotifier, void>(
  UserReportNotifier.new,
);

class UserReportNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // No initial build action needed
  }

  Future<void> reportUser({
    required String reportedUserId,
    required String description,
  }) async {
    state = const AsyncLoading();

    try {
      final useCase = ref.read(reportUserUseCaseProvider);
      await useCase.call(
        targetId: int.parse(reportedUserId),
        reason: 'OTHER', // UI does not support selecting a reason yet.
        description: description,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow; // Allow the UI to catch the error
    }
  }
}