
import 'package:dartz/dartz.dart';

import '../../domain/entity/test_result.dart';
import '../../domain/repository/test_result_repository.dart';
import '../datasource/test_result_remote_datasource.dart';

class TestResultRepositoryImpl implements TestResultRepository {
  final TestResultRemoteDataSource remoteDataSource;

  TestResultRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Exception, TestResult>> getTestResult(String testType) async {
    try {
      final dto = await remoteDataSource.fetchTestResult(testType);
      return Right(dto.toEntity());
    } catch (e) {
      return Left(Exception('Failed to get test result: $e'));
    }
  }
}
