
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import 'package:soulfit_client/feature/authentication/presentation/screens/find_id_screen.dart';
import 'package:soulfit_client/feature/main_profile/ui/screen/main_profile_screen.dart';
import 'package:soulfit_client/feature/meeting/main/ui/screen/meeting_home_screen.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/notification_screen.dart';
import 'package:soulfit_client/feature/survey/presentation/screens/life_survey_screen.dart';
import 'package:soulfit_client/feature/survey/presentation/screens/love_survey_screen.dart';

import '../../core/dev/sandbox_screen.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';
import '../../feature/authentication/presentation/screens/register_screen.dart';
import '../../feature/community/presentation/screens/community_screen.dart';
import '../../feature/community/presentation/screens/create_post_screen.dart';
import '../../feature/matching/chat/presentation/screen/chat_screen.dart';
import '../../feature/meeting/main/ui/screen/meeting_list_screen.dart';
import '../../feature/meeting/main/ui/screen/meeting_detail_screen.dart';
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
  static const String lifeSurvey = '/life-survey';
  static const String loveSurvey = '/love-survey';
  static const String meetingMain = '/meeting-main';
  static const String meetingList = '/meeting-list';
  static const String meetingDetail = '/meeting-detail';
  static const String chat = '/chat';



  static const List<String> allRoutes = [
    login,
    home,
    register,
    findId,
    payment,
    tossPayment,
    community,
    createPost,
    noti,
    mainProfile,
    lifeSurvey,
    loveSurvey,
    meetingMain,
    meetingList,
    meetingDetail,
    chat
  ];
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.login,
  routes: [
    GoRoute(
      path: AppRoutes.login,
      name: 'login',
      builder: (context, state) => SoulfitLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      name: 'register',
      builder: (context, state) => const SignUpScreenV3(),
    ),
    GoRoute(
      path: AppRoutes.findId,
      name: 'findId',
      builder: (context, state) => const FindIdScreen(),
    ),
    GoRoute(
      path: AppRoutes.sandbox,
      name: 'sandbox',
      builder: (context, state) => const SandboxScreen(),
    ),
    GoRoute(
      path: AppRoutes.payment,
      name: 'payment',
      builder: (context, state) => const PortoneDelegator(),
    ),
    GoRoute(
      path: AppRoutes.tossPayment,
      name: 'toss-payments',
      builder: (context, state) => const PaymentWidgetExamplePage2(),
    ),
    GoRoute(
      path: AppRoutes.createPost,
      name: 'create-post',
      builder: (context, state) => const CreatePostScreen(),
    ),
    GoRoute(
      path: '/main-profile/:viewer/:target',
      name: 'main-profile',
      builder: (context, state) => MainProfileScreen(
        viewerUserId: state.pathParameters['viewer'] as String,
        targetUserId: state.pathParameters['target'] as String,
      ),
    ),
    GoRoute(
      path: AppRoutes.lifeSurvey,
      name: 'life-survey',
      builder: (context, state) => const LifeSurveyScreen(),
    ),
    GoRoute(
      path: AppRoutes.loveSurvey,
      name: 'love-survey',
      builder: (context, state) => const LoveSurveyScreen(),
    ),
    GoRoute(
      path: AppRoutes.meetingMain,
      name: 'meeting-main',
      builder: (context, state) => const MeetingHomeScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.meetingList}/:listType',
      name: 'meeting-list',
      builder: (context, state) => MeetingListScreen(
        listType: state.pathParameters['listType']!,
      ),
    ),
    GoRoute(
      path: '/meeting-detail/:meetingId',
      name: 'meeting-detail',
      builder: (context, state) => MeetingDetailScreen(
        meetingId: state.pathParameters['meetingId']!,
      ),
    ),
    // GoRoute(
    //   path: AppRoutes.conversation_received,
    //   name: 'conversation-received',
    //   builder: (context, state) => const ReceivedConversationRequestScreen(),
    // ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: SharedNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.community,
              name: 'community',
              builder: (context, state) => const CommunityScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.chat,
              name: 'chat',
              builder: (context, state) => const ChatScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.noti,
              name: 'notification',
              builder: (context, state) => const NotificationScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) {
                return Consumer(builder: (context, ref, child) {
                  final userId =
                      ref.watch(authNotifierProvider.select((value) => value.user?.id));
                  if (userId == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return MainProfileScreen(
                    viewerUserId: userId,
                    targetUserId: userId,
                  );
                });
              },
            ),
          ],
        ),
      ],
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

