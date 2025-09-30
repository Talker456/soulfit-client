
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/test_result/domain/usecase/get_test_result_usecase.dart';

import '../state/test_result_state.dart';

class TestResultNotifier extends StateNotifier<TestResultState> {
  final GetTestResultUseCase _getTestResultUseCase;

  TestResultNotifier(this._getTestResultUseCase) : super(TestResultInitial());

  Future<void> getTestResult(String testType) async {
    state = TestResultLoading();
    final result = await _getTestResultUseCase(testType);
    result.fold(
      (failure) => state = TestResultError(failure.toString()),
      (testResult) => state = TestResultLoaded(testResult),
    );
  }
}
