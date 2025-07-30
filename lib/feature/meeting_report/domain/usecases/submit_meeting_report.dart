// lib/feature/meeting_report/domain/usecases/submit_meeting_report.dart

import '../repositories/meeting_report_repository.dart';
import '../../data/models/meeting_report_request.dart';

class ReportMeetingUseCase {
  final MeetingReportRepository repository;

  ReportMeetingUseCase({required this.repository});

  Future<void> call(MeetingReportRequest request) async {
    await repository.reportMeeting(request);
  }
}
