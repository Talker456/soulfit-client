import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/impression_result.dart';
import '../../domain/usecases/get_impression_result.dart';

class ImpressionState {
  final ImpressionResult? result; // 조회 결과
  final bool loading;
  final String? error;

  const ImpressionState({this.result, this.loading = false, this.error});

  ImpressionState copyWith({
    ImpressionResult? result,
    bool? loading,
    String? error,
    bool clearError = false,
  }) => ImpressionState(
    result: result ?? this.result,
    loading: loading ?? this.loading,
    error: clearError ? null : (error ?? this.error),
  );
}

class ImpressionNotifier extends StateNotifier<ImpressionState> {
  final GetImpressionResult _getResult;
  final String? targetUserId;

  ImpressionNotifier(this._getResult, {required this.targetUserId})
    : super(const ImpressionState());

  Future<void> load() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final id = targetUserId;
      final result =
          (id == null || id.isEmpty)
              ? await _getResult('me')
              : await _getResult(id);

      state = state.copyWith(result: result, loading: false);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
