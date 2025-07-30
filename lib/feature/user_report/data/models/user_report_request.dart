// lib/feature/user_report/data/models/user_report_request.dart

class UserReportRequest {
  final String reporterUserId;
  final String reportedUserId;
  final String reason;

  UserReportRequest({
    required this.reporterUserId,
    required this.reportedUserId,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'reporter_user_id': reporterUserId,
      'reported_user_id': reportedUserId,
      'reason': reason,
    };
  }
}
