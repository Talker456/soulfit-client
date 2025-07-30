// lib/feature/user_report/domain/usecases/report_user.dart

import '../repositories/user_report_repository.dart';
import '../../data/models/user_report_request.dart';

class ReportUserUseCase {
  final UserReportRepository repository;

  ReportUserUseCase({required this.repository});

  Future<void> call(UserReportRequest request) async {
    await repository.reportUser(request);
  }
}
