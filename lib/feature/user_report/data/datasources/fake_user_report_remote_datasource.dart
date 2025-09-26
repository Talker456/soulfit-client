// lib/feature/user_report/data/datasources/fake_user_report_remote_datasource.dart

import 'user_report_api.dart';

class FakeUserReportRemoteDataSource implements UserReportRemoteDataSource {
  @override
  Future<void> reportUser({
    required String reporterUserId,
    required String reportedUserId,
    required String reason,
  }) async {
    // 테스트를 위한 지연 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    // 성공적으로 신고가 접수되었다고 가정
    print('Fake Report: $reporterUserId reported $reportedUserId for: $reason');

    // 특정 조건에서 에러 시뮬레이션 (선택사항)
    if (reason.isEmpty) {
      throw Exception('신고 사유가 비어있습니다.');
    }
  }
}