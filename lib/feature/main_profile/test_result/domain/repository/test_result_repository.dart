
import 'package:dartz/dartz.dart';
import 'package:soulfit_client/feature/main_profile/test_result/domain/entity/test_result.dart';

abstract class TestResultRepository {
  Future<Either<Exception, TestResult>> getTestResult(String testType);
}
