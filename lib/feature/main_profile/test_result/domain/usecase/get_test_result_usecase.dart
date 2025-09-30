
import 'package:dartz/dartz.dart';

import '../entity/test_result.dart';
import '../repository/test_result_repository.dart';

class GetTestResultUseCase {
  final TestResultRepository repository;

  GetTestResultUseCase(this.repository);

  Future<Either<Exception, TestResult>> call(String testType) {
    return repository.getTestResult(testType);
  }
}
