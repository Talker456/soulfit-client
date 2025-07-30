// lib/feature/meeting_report/data/datasources/meeting_report_remote_datasource.dart

import 'package:dio/dio.dart';

class MeetingReportApi {
  final Dio dio;

  MeetingReportApi({required this.dio});

  Future<void> reportMeeting({
    required String reporterUserId,
    required String meetingId,
    required String reason,
  }) async {
    try {
      final response = await dio.post(
        '/report/meeting',
        data: {
          'reporter_user_id': reporterUserId,
          'meeting_id': meetingId,
          'reason': reason,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('모임 신고에 실패했습니다.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
