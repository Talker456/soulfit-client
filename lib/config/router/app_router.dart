import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/authentication/presentation/screens/find_id_screen.dart';

import '../../core/dev/sandbox_screen.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';
import '../../feature/authentication/presentation/screens/register_screen.dart';
import '../../feature/community/presentation/screens/community_screen.dart';
import '../../feature/community/presentation/screens/create_post_screen.dart';
import '../di/provider.dart';

class AppRoutes {
  static const String sandbox = '/sandbox';

  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String findId = '/findId';
  static const String community = '/community';
  static const String post = '/post';


  static const List<String> allRoutes = [
    login, home, register, findId, community, post,
  ];
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
    GoRoute(
        path: AppRoutes.findId,
        name : 'findId',
        builder: (context,state) => const FindIdScreen(),
    ),
    GoRoute(
        path: AppRoutes.sandbox,
        name: 'sandbox',
        builder: (context,state) => const SandboxScreen()),
    GoRoute(
        path: AppRoutes.community,
        name: 'community',
        builder: (context,state) => const CommunityScreen()),
    GoRoute(
        path: AppRoutes.post,
        name: 'post',
        builder: (context,state) => const CreatePostScreen()),
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