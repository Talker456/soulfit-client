// lib/feature/user_report/domain/repositories/user_report_repository.dart

import '../../data/models/user_report_request.dart';

abstract class UserReportRepository {
  Future<void> reportUser(UserReportRequest request);
}
