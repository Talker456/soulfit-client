import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/like_user.dart';
import '../../domain/usecases/get_users_who_like_me.dart';
import '../../domain/usecases/get_users_i_like.dart';

enum LikeTab { likedMe, iLike }

class CheckLikeState {
  final LikeTab tab;
  final List<LikeUser> users;
  final bool loading;
  final String? error;

  const CheckLikeState({
    this.tab = LikeTab.likedMe,
    this.users = const [],
    this.loading = false,
    this.error,
  });

  CheckLikeState copyWith({
    LikeTab? tab,
    List<LikeUser>? users,
    bool? loading,
    String? error,
    bool clearError = false,
  }) => CheckLikeState(
    tab: tab ?? this.tab,
    users: users ?? this.users,
    loading: loading ?? this.loading,
    error: clearError ? null : (error ?? this.error),
  );
}

class CheckLikeNotifier extends StateNotifier<CheckLikeState> {
  final GetUsersWhoLikeMe _getLikedMe;
  final GetUsersILike _getILike;

  CheckLikeNotifier(this._getLikedMe, this._getILike)
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
      final msg =
          e.toString().contains('Failed host lookup')
              ? '서버에 연결할 수 없어요. 네트워크나 서버 주소를 확인해주세요.'
              : e.toString();
      state = state.copyWith(loading: false, error: msg);
    }
  }

  void switchTab(LikeTab tab) {
    state = state.copyWith(tab: tab);
    load();
  }
}
