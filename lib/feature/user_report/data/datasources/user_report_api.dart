// lib/feature/user_report/data/datasources/user_report_api.dart

import 'package:dio/dio.dart';

class UserReportApi {
  final Dio dio;

  UserReportApi({required this.dio});

  Future<void> reportUser({
    required String reporterUserId,
    required String reportedUserId,
    required String reason,
  }) async {
    try {
      final response = await dio.post(
        '/report/user',
        data: {
          'reporter_user_id': reporterUserId,
          'reported_user_id': reportedUserId,
          'reason': reason,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('신고에 실패했습니다.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
