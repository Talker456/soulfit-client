import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:soulfit_client/config/di/provider.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../domain/usecase/register_usecase.dart';

// Auth State 정의
enum AuthState { initial, loading, success, error }

// Auth State 클래스
class AuthStateData {
  final AuthState state;
  final User? user;
  final String? errorMessage;

  AuthStateData({
    required this.state,
    this.user,
    this.errorMessage,
  });

  AuthStateData copyWith({
    AuthState? state,
    User? user,
    String? errorMessage,
  }) {
    return AuthStateData(
      state: state ?? this.state,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Riverpod StateNotifier로 변경
class AuthNotifier extends StateNotifier<AuthStateData> {
  final LoginUseCase loginUseCase;

  AuthNotifier({
    required this.loginUseCase,
  }) : super(AuthStateData(state: AuthState.initial));

  Future<void> login(String email, String password) async {
    print('login call on auth_riverpod');
    state = state.copyWith(state: AuthState.loading);

    try {
      final user = await loginUseCase.execute(email, password);

      print('[login_riverpod] : User Logged in :'+user.username+", "+user.email);

      state = state.copyWith(
        state: AuthState.success,
        user: user,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        state: AuthState.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> loadCurrentUser() async {
    state = state.copyWith(state: AuthState.loading);
    try {
      // 실제로는 GetCurrentUser UseCase를 호출하여 사용자 정보를 가져와야 합니다.
      // 예시: final user = await GetCurrentUser(sl()).call(NoParams());
      // 여기서는 임시로 null 또는 저장된 사용자 정보를 가져온다고 가정합니다.
      final User? currentUser = null; // 실제 구현에서는 저장된 사용자 정보를 로드합니다.

      if (currentUser != null) {
        state = state.copyWith(state: AuthState.success, user: currentUser);
      } else {
        state = state.copyWith(state: AuthState.initial); // 로그인되지 않은 상태
      }
    } catch (e) {
      state = state.copyWith(state: AuthState.error, errorMessage: e.toString());
    }
  }
}

