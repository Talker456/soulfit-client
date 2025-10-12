// lib/feature/meeting_report/data/repository_impl/meeting_report_repository_impl.dart

import '../models/meeting_report_request.dart';
import '../datasources/meeting_report_remote_datasource.dart';
import '../../domain/repositories/meeting_report_repository.dart';

class MeetingReportRepositoryImpl implements MeetingReportRepository {
  final MeetingReportRemoteDataSource remoteDataSource;

  MeetingReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> reportMeeting(MeetingReportRequest request) async {
    await remoteDataSource.reportMeeting(request);
  }
}
