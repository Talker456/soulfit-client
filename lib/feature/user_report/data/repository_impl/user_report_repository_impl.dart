// lib/feature/user_report/data/repository_impl/user_report_repository_impl.dart

import '../models/user_report_request.dart';
import '../datasources/user_report_api.dart';
import '../../domain/repositories/user_report_repository.dart';

class UserReportRepositoryImpl implements UserReportRepository {
  final UserReportApi remoteDataSource;

  UserReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> reportUser(UserReportRequest request) async {
    await remoteDataSource.reportUser(
      reporterUserId: request.reporterUserId,
      reportedUserId: request.reportedUserId,
      reason: request.reason,
    );
  }
}
