
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/create_review.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_review_keywords.dart';
import 'package:soulfit_client/feature/matching/review/presentation/state/create_review_state.dart';

@injectable
class CreateReviewNotifier extends StateNotifier<CreateReviewState> {
  final CreateReviewUseCase _createReviewUseCase;
  final GetReviewKeywordsUseCase _getReviewKeywordsUseCase;

  CreateReviewNotifier(
    this._createReviewUseCase,
    this._getReviewKeywordsUseCase,
  ) : super(CreateReviewState());

  Future<void> fetchKeywords() async {
    state = state.copyWith(status: CreateReviewStatus.keywordsLoading);
    try {
      final keywords = await _getReviewKeywordsUseCase.call();
      state = state.copyWith(
        status: CreateReviewStatus.keywordsLoaded,
        keywords: keywords,
      );
    } catch (e) {
      state = state.copyWith(
        status: CreateReviewStatus.error,
        error: e.toString(),
      );
    }
  }

  Future<void> submitReview({
    required int revieweeId,
    required int conversationRequestId,
    required String comment,
    required List<String> keywords,
  }) async {
    state = state.copyWith(status: CreateReviewStatus.loading);
    try {
      await _createReviewUseCase.call(
        revieweeId: revieweeId,
        conversationRequestId: conversationRequestId,
        comment: comment,
        keywords: keywords,
      );
      state = state.copyWith(status: CreateReviewStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: CreateReviewStatus.error,
        error: e.toString(),
      );
    }
  }
}
