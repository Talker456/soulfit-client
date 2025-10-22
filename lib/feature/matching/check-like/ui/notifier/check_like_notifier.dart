import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/ai_match.dart';
import '../../domain/entities/like_user.dart';
import '../../domain/usecases/get_users_who_like_me.dart';
import '../../domain/usecases/get_users_i_like.dart';
import '../../domain/usecases/get_ai_match.dart';

enum LikeTab { likedMe, iLike }

class CheckLikeState {
  final LikeTab tab;
  final List<LikeUser> users;
  final bool loading;
  final String? error;
  final AsyncValue<List<AiMatch>> aiMatchState;

  const CheckLikeState({
    this.tab = LikeTab.likedMe,
    this.users = const [],
    this.loading = false,
    this.error,
    this.aiMatchState = const AsyncValue.data([]),
  });

  CheckLikeState copyWith({
    LikeTab? tab,
    List<LikeUser>? users,
    bool? loading,
    String? error,
    bool clearError = false,
    AsyncValue<List<AiMatch>>? aiMatchState,
  }) => CheckLikeState(
    tab: tab ?? this.tab,
    users: users ?? this.users,
    loading: loading ?? this.loading,
    error: clearError ? null : (error ?? this.error),
    aiMatchState: aiMatchState ?? this.aiMatchState,
  );
}

class CheckLikeNotifier extends StateNotifier<CheckLikeState> {
  final GetUsersWhoLikeMe _getLikedMe;
  final GetUsersILike _getILike;
  final GetAiMatch _getAiMatch;

  CheckLikeNotifier(this._getLikedMe, this._getILike, this._getAiMatch)
      : super(const CheckLikeState());

  Future<void> load() async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final users = switch (state.tab) {
        LikeTab.likedMe => await _getLikedMe(),
        LikeTab.iLike => await _getILike(),
      };
      state = state.copyWith(users: users, loading: false);
    } catch (e) {
      final msg = e.toString().contains('Failed host lookup')
          ? '서버에 연결할 수 없어요. 네트워크나 서버 주소를 확인해주세요.'
          : e.toString();
      state = state.copyWith(loading: false, error: msg);
    }
  }

  void switchTab(LikeTab tab) {
    state = state.copyWith(tab: tab);
    load();
  }

  Future<void> getAiMatch(List<int> candidateUserIds) async {
    state = state.copyWith(aiMatchState: const AsyncValue.loading());
    try {
      final result = await _getAiMatch(candidateUserIds);
      state = state.copyWith(aiMatchState: AsyncValue.data(result));
    } catch (e) {
      state = state.copyWith(aiMatchState: AsyncValue.error(e, StackTrace.current));
    }
  }
}
