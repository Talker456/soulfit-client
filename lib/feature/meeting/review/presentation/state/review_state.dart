import '../../domain/entities/review.dart';

/// 리뷰 화면 상태
class ReviewState {
  final bool loading;
  final List<Review> reviews;
  final ReviewStats? stats;
  final String? error;

  const ReviewState({
    this.loading = false,
    this.reviews = const [],
    this.stats,
    this.error,
  });

  ReviewState copyWith({
    bool? loading,
    List<Review>? reviews,
    ReviewStats? stats,
    String? error,
  }) {
    return ReviewState(
      loading: loading ?? this.loading,
      reviews: reviews ?? this.reviews,
      stats: stats ?? this.stats,
      error: error,
    );
  }
}

/// 리뷰 작성 상태
class CreateReviewState {
  final bool submitting;
  final bool success;
  final String? error;

  const CreateReviewState({
    this.submitting = false,
    this.success = false,
    this.error,
  });

  CreateReviewState copyWith({
    bool? submitting,
    bool? success,
    String? error,
  }) {
    return CreateReviewState(
      submitting: submitting ?? this.submitting,
      success: success ?? this.success,
      error: error,
    );
  }
}
