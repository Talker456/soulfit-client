
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_reviews_for_user.dart';
import 'package:soulfit_client/feature/matching/review/presentation/state/user_reviews_state.dart';

@injectable
class UserReviewsNotifier extends StateNotifier<UserReviewsState> {
  final GetReviewsForUserUseCase _getReviewsForUserUseCase;

  UserReviewsNotifier(this._getReviewsForUserUseCase) : super(UserReviewsState());

  Future<void> fetchUserReviews(int userId) async {
    state = state.copyWith(status: UserReviewsStatus.loading);
    try {
      final reviews = await _getReviewsForUserUseCase.call(userId);
      state = state.copyWith(
        status: UserReviewsStatus.success,
        reviews: reviews,
      );
    } catch (e) {
      state = state.copyWith(
        status: UserReviewsStatus.error,
        error: e.toString(),
      );
    }
  }
}
