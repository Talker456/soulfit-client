
import '../../domain/entity/test_result.dart';

sealed class TestResultState {}

class TestResultInitial extends TestResultState {}

class TestResultLoading extends TestResultState {}

class TestResultLoaded extends TestResultState {
  final TestResult testResult;

  TestResultLoaded(this.testResult);
}

class TestResultError extends TestResultState {
  final String message;

  TestResultError(this.message);
}
