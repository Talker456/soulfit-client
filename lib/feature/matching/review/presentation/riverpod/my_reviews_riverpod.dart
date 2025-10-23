
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_my_reviews.dart';
import 'package:soulfit_client/feature/matching/review/presentation/state/my_reviews_state.dart';

@injectable
class MyReviewsNotifier extends StateNotifier<MyReviewsState> {
  final GetMyReviewsUseCase _getMyReviewsUseCase;

  MyReviewsNotifier(this._getMyReviewsUseCase) : super(MyReviewsState());

  Future<void> fetchMyReviews() async {
    state = state.copyWith(status: MyReviewsStatus.loading);
    try {
      final reviews = await _getMyReviewsUseCase.call();
      state = state.copyWith(
        status: MyReviewsStatus.success,
        reviews: reviews,
      );
    } catch (e) {
      state = state.copyWith(
        status: MyReviewsStatus.error,
        error: e.toString(),
      );
    }
  }
}
