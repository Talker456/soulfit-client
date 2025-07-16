import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';
import '../../feature/authentication/presentation/screens/signup_screen_v3.dart';
import '../di/provider.dart';

class AppRoutes {
  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => SoulfitLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      // builder: (context, state) => const SignUpScreen(),
      builder: (context, state) => const SignUpScreenV3(),
    ),
  ],
  redirect: (context, state) {
    // 인증 상태에 따른 리다이렉트 로직
    final container = ProviderContainer();
    final authState = container.read(authNotifierProvider);

    if (authState.state == AuthState.success &&
        state.uri.toString() == AppRoutes.login) {
      return AppRoutes.home;
    }

    return null;
  },
);