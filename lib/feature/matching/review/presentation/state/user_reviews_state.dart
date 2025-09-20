
import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';

enum UserReviewsStatus { initial, loading, success, error }

class UserReviewsState {
  final UserReviewsStatus status;
  final List<Review> reviews;
  final String? error;

  UserReviewsState({
    this.status = UserReviewsStatus.initial,
    this.reviews = const [],
    this.error,
  });

  UserReviewsState copyWith({
    UserReviewsStatus? status,
    List<Review>? reviews,
    String? error,
  }) {
    return UserReviewsState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      error: error ?? this.error,
    );
  }
}
