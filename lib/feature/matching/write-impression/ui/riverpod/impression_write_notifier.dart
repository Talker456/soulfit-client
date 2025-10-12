import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/impression_feedback.dart';
import '../../domain/usecases/submit_impression_feedback.dart';

class ImpressionWriteState {
  final List<String> selectedTags;
  final String comment;
  final bool loading;
  final String? successId;
  final String? error;

  const ImpressionWriteState({
    this.selectedTags = const [],
    this.comment = '',
    this.loading = false,
    this.successId,
    this.error,
  });

  bool get canSubmit => selectedTags.isNotEmpty && comment.trim().isNotEmpty;

  ImpressionWriteState copyWith({
    List<String>? selectedTags,
    String? comment,
    bool? loading,
    String? successId,
    String? error,
  }) {
    return ImpressionWriteState(
      selectedTags: selectedTags ?? this.selectedTags,
      comment: comment ?? this.comment,
      loading: loading ?? this.loading,
      successId: successId,
      error: error,
    );
  }
}

class ImpressionWriteNotifier extends StateNotifier<ImpressionWriteState> {
  final SubmitImpressionFeedback _submit;
  final String? targetUserId;

  ImpressionWriteNotifier(this._submit, {required this.targetUserId})
    : super(const ImpressionWriteState());

  void toggleTag(String tagId) {
    final list = [...state.selectedTags];
    if (list.contains(tagId)) {
      list.remove(tagId);
    } else {
      if (list.length >= 2) return;
      list.add(tagId);
    }
    state = state.copyWith(selectedTags: list);
  }

  void setComment(String text) {
    state = state.copyWith(comment: text);
  }

  Future<void> submit() async {
    if (!state.canSubmit || state.loading) return;
    state = state.copyWith(loading: true, error: null, successId: null);
    try {
      final effectiveId =
          (targetUserId != null && targetUserId!.trim().isNotEmpty)
              ? targetUserId!.trim()
              : 'me';

      final id = await _submit(
        ImpressionFeedback(
          targetUserId: effectiveId,
          tagIds: state.selectedTags,
          comment: state.comment.trim(),
        ),
      );
      state = state.copyWith(loading: false, successId: id);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
