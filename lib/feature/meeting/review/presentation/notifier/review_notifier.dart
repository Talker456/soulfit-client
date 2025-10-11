import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_reviews_usecase.dart';
import '../../domain/usecases/get_review_stats_usecase.dart';
import '../state/review_state.dart';

/// 리뷰 조회 Notifier
class ReviewNotifier extends StateNotifier<ReviewState> {
  final GetReviewsUseCase getReviewsUseCase;
  final GetReviewStatsUseCase getReviewStatsUseCase;

  ReviewNotifier({
    required this.getReviewsUseCase,
    required this.getReviewStatsUseCase,
  }) : super(const ReviewState());

  /// 리뷰 목록과 통계를 조회합니다
  Future<void> loadReviews(String meetingId) async {
    state = state.copyWith(loading: true, error: null);
    try {
      // 리뷰 목록과 통계를 병렬로 조회
      final results = await Future.wait([
        getReviewsUseCase.execute(meetingId),
        getReviewStatsUseCase.execute(meetingId),
      ]);

      state = state.copyWith(
        loading: false,
        reviews: results[0] as List,
        stats: results[1],
      );
    } catch (e) {
      state = state.copyWith(
        loading: false,
        error: e.toString(),
      );
    }
  }

  /// 새로고침
  Future<void> refresh(String meetingId) async {
    await loadReviews(meetingId);
  }
}
