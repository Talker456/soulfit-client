import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/create_review_usecase.dart';
import '../state/review_state.dart';

/// 리뷰 작성 Notifier
class CreateReviewNotifier extends StateNotifier<CreateReviewState> {
  final CreateReviewUseCase createReviewUseCase;

  CreateReviewNotifier(this.createReviewUseCase)
      : super(const CreateReviewState());

  /// 리뷰를 작성합니다
  Future<void> createReview({
    required String meetingId,
    required double rating,
    required String content,
    List<String> keywords = const [],
  }) async {
    state = state.copyWith(submitting: true, error: null, success: false);
    try {
      final request = CreateReviewRequest(
        meetingId: meetingId,
        rating: rating,
        content: content,
        keywords: keywords,
      );

      await createReviewUseCase.execute(request);

      state = state.copyWith(
        submitting: false,
        success: true,
      );
    } catch (e) {
      state = state.copyWith(
        submitting: false,
        error: e.toString(),
      );
    }
  }

  /// 상태 초기화
  void reset() {
    state = const CreateReviewState();
  }
}
