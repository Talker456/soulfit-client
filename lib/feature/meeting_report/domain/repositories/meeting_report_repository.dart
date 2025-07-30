// lib/feature/meeting_report/domain/repositories/meeting_report_repository.dart

import '../../data/models/meeting_report_request.dart';

abstract class MeetingReportRepository {
  Future<void> reportMeeting(MeetingReportRequest request);
}
