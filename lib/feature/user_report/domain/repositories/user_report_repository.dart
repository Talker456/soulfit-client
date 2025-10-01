import '../entities/user_report.dart';

abstract class UserReportRepository {
  Future<void> reportUser(UserReport report);
}