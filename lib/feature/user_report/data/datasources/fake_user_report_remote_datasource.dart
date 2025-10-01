import '../models/user_report_request.dart';
import 'user_report_api.dart';

class FakeUserReportRemoteDataSource implements UserReportRemoteDataSource {
  @override
  Future<void> reportUser(UserReportRequestDto request) async {
    // Simulate network delay for testing
    await Future.delayed(const Duration(seconds: 1));

    // Simulate a successful report
    print(
        'Fake Report: User reported target ${request.targetId} '
            'of type ${request.targetType} '
            'for reason \'${request.reason}\' '
            'with description: "${request.description}"'
    );

    // Optionally, simulate an error condition
    if (request.description.isEmpty) {
      throw Exception('신고 내용이 비어있습니다.');
    }

    // To simulate a failure case, you could uncomment the following line:
    // throw Exception('Fake server error!');
  }
}