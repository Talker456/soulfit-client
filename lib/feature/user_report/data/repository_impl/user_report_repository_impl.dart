import '../../domain/entities/user_report.dart';
import '../../domain/repositories/user_report_repository.dart';
import '../datasources/user_report_api.dart';
import '../models/user_report_request.dart';

class UserReportRepositoryImpl implements UserReportRepository {
  final UserReportRemoteDataSource remoteDataSource;

  UserReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> reportUser(UserReport report) async {
    try {
      final requestDto = UserReportRequestDto.fromEntity(report);
      await remoteDataSource.reportUser(requestDto);
    } catch (e) {
      rethrow;
    }
  }
}