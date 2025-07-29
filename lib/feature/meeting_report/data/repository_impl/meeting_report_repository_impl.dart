// lib/feature/meeting_report/data/repository_impl/meeting_report_repository_impl.dart

import '../models/meeting_report_request.dart';
import '../datasources/meeting_report_remote_datasource.dart';
import '../../domain/repositories/meeting_report_repository.dart';

class MeetingReportRepositoryImpl implements MeetingReportRepository {
  final MeetingReportApi remoteDataSource;

  MeetingReportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> reportMeeting(MeetingReportRequest request) async {
    await remoteDataSource.reportMeeting(
      reporterUserId: request.reporterUserId,
      meetingId: request.meetingId,
      reason: request.reason,
    );
  }
}
