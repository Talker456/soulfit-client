
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/filter/domain/entities/dating_filter.dart';
import 'package:soulfit_client/feature/matching/filter/domain/usecases/get_saved_filter_usecase.dart';
import 'package:soulfit_client/feature/matching/main/domain/usecases/get_recommended_users_usecase.dart';
import 'package:soulfit_client/feature/matching/recommendation/domain/usecase/send_swipe_usecase.dart';
import 'package:soulfit_client/feature/matching/recommendation/presentation/state/recommended_user_state.dart';

class RecommendedUserNotifier extends StateNotifier<RecommendedUserState> {
  final GetRecommendedUsersUseCase _getRecommendedUsersUseCase;
  final SendSwipeUseCase _sendSwipeUseCase;
  final GetSavedFilterUseCase _getSavedFilterUseCase;
  
  int _page = 0;
  static const _size = 10; // 한 번에 불러올 유저 수
  DatingFilter _activeFilter = DatingFilter.defaultFilter;

  RecommendedUserNotifier({
    required GetRecommendedUsersUseCase getRecommendedUsersUseCase,
    required SendSwipeUseCase sendSwipeUseCase,
    required GetSavedFilterUseCase getSavedFilterUseCase,
  })  : _getRecommendedUsersUseCase = getRecommendedUsersUseCase,
        _sendSwipeUseCase = sendSwipeUseCase,
        _getSavedFilterUseCase = getSavedFilterUseCase,
        super(RecommendedUserLoading()) {
    fetchInitialUsers();
  }

  Future<void> fetchInitialUsers() async {
    _page = 0;
    state = RecommendedUserLoading();
    try {
      final savedFilter = await _getSavedFilterUseCase();
      _activeFilter = savedFilter ?? DatingFilter.defaultFilter;

      final users = await _getRecommendedUsersUseCase(_activeFilter, limit: _size);
      state = RecommendedUserLoaded(users: users, hasReachedMax: users.length < _size);
    } catch (e) {
      state = const RecommendedUserError('추천 유저를 불러오는 데 실패했습니다.');
    }
  }

  Future<void> fetchMoreUsers() async {
    if (state is RecommendedUserLoaded && !(state as RecommendedUserLoaded).hasReachedMax) {
      final currentState = state as RecommendedUserLoaded;
      _page++;
      try {
        final newUsers = await _getRecommendedUsersUseCase(_activeFilter, limit: _size);
        state = currentState.copyWith(
          users: List.of(currentState.users)..addAll(newUsers),
          hasReachedMax: newUsers.length < _size,
        );
      } catch (e) {
        _page--;
      }
    }
  }

  Future<void> swipeUser({required int userId, required bool isLike}) async {
    if (state is! RecommendedUserLoaded) return;

    final currentState = state as RecommendedUserLoaded;
    final originalUsers = List.of(currentState.users);

    // Optimistic update: remove the user from the list immediately
    final updatedUsers = originalUsers.where((user) => user.userId != userId).toList();
    state = currentState.copyWith(users: updatedUsers);

    try {
      await _sendSwipeUseCase(SendSwipeParams(userId: userId, isLike: isLike));
    } catch (e) {
      // If the API call fails, revert the state and show an error
      state = currentState.copyWith(users: originalUsers);
      // Optionally, you can set an error message in the state to show in the UI
      print("Failed to send swipe: $e");
    }
  }
}
