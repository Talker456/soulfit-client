// lib/feature/meeting_report/data/models/meeting_report_request_model.dart

class MeetingReportRequest {
  final String reporterUserId;
  final String meetingId;
  final String reason;

  MeetingReportRequest({
    required this.reporterUserId,
    required this.meetingId,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'reporter_user_id': reporterUserId,
      'meeting_id': meetingId,
      'reason': reason,
    };
  }
}
