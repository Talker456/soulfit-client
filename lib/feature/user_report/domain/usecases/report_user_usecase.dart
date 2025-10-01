import '../entities/user_report.dart';
import '../repositories/user_report_repository.dart';

class ReportUserUseCase {
  final UserReportRepository repository;

  ReportUserUseCase({required this.repository});

  Future<void> call({
    required int targetId,
    required String reason,
    required String description,
  }) async {
    final report = UserReport(
      targetId: targetId,
      reason: reason,
      description: description,
    );
    await repository.reportUser(report);
  }
}