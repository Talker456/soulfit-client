import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/authentication/presentation/screens/find_id_screen.dart';
import 'package:soulfit_client/feature/main_profile/ui/screen/main_profile_screen.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/notification_screen.dart';

import '../../core/dev/sandbox_screen.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';
import '../../feature/authentication/presentation/screens/register_screen.dart';
import '../../feature/community/presentation/screens/community_screen.dart';
import '../../feature/community/presentation/screens/create_post_screen.dart';
import '../../feature/payment/presentation/ui/portone_delegator.dart';
import '../../feature/payment/presentation/ui/tosspayments_widget_v2.dart';
import '../di/provider.dart';

class AppRoutes {
  static const String sandbox = '/sandbox';

  static const String login = '/login';
  static const String home = '/home';
  static const String register = '/register';
  static const String findId = '/findId';
  static const String payment = '/payment';
  static const String tossPayment = '/toss-pay';
  static const String community = '/community';
  static const String createPost = '/create-post';
  static const String noti = '/notification';
  static const String mainProfile = '/main-profile/1/2';

  static const List<String> allRoutes = [
    login, home, register, findId, payment, tossPayment,
    community, createPost,noti, mainProfile,
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
        path: AppRoutes.payment,
        name: 'payment',
        builder: (context,state)=> const PortoneDelegator()),
    GoRoute(
        path: AppRoutes.tossPayment,
        name: 'toss-payments',
        // builder: (context,state)=> const PaymentWidgetExamplePage()),
        builder: (context,state)=> const PaymentWidgetExamplePage2()),
    GoRoute(
        path: AppRoutes.community,
        name: 'community',
        builder: (context,state)=> const CommunityScreen()),
    GoRoute(
        path: AppRoutes.createPost,
        name: 'create-post',
        builder: (context,state)=> const CreatePostScreen()),
    GoRoute(
        path: AppRoutes.noti,
        name: 'notification',
        builder: (context,state)=> const NotificationScreen()),
    GoRoute(
        path: '/main-profile/:viewer/:target',
        name: 'main-profile',

        builder: (context,state) =>
          MainProfileScreen(
              viewerUserId: state.pathParameters['viewer'] as String,
              targetUserId: state.pathParameters['target'] as String
          )
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