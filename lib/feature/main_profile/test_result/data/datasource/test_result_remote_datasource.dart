
import '../model/test_result_dto.dart';

abstract class TestResultRemoteDataSource {
  Future<TestResultDto> fetchTestResult(String testType);
}
