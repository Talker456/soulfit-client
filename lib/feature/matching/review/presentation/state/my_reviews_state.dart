
import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';

enum MyReviewsStatus { initial, loading, success, error }

class MyReviewsState {
  final MyReviewsStatus status;
  final List<Review> reviews;
  final String? error;

  MyReviewsState({
    this.status = MyReviewsStatus.initial,
    this.reviews = const [],
    this.error,
  });

  MyReviewsState copyWith({
    MyReviewsStatus? status,
    List<Review>? reviews,
    String? error,
  }) {
    return MyReviewsState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      error: error ?? this.error,
    );
  }
}
