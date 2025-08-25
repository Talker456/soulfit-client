
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
import '../../feature/main_profile/ui/screen/past_apply_list.dart';
import '../../feature/main_profile/ui/screen/test_result_report.dart';
import '../../feature/matching/chat/presentation/screen/chat_screen.dart';
import '../../feature/matching/chat/presentation/screen/chat_detail_screen.dart';
import '../../feature/meeting/main/ui/screen/meeting_list_screen.dart';
import '../../feature/meeting/main/ui/screen/meeting_detail_screen.dart';
import '../../feature/meeting/main/ui/screen/recently_open_group.dart';
import '../../feature/payment/presentation/ui/portone_delegator.dart';
import '../../feature/payment/presentation/ui/tosspayments_widget_v2.dart';
import '../di/provider.dart';

import '../../feature/community/presentation/screens/community_main.dart';
import '../../feature/coupon/presentation/screens/coupon_list.dart';
import '../../feature/matching/main/presentation/screen/dating_main.dart';
import '../../feature/main_profile/ui/screen/history_group_list.dart';
import '../../feature/main_profile/ui/screen/host_history_group_list.dart';
import '../../feature/mainscreen/group.dart';
import '../../feature/mainscreen/mainscreen.dart';
import '../../feature/meeting/main/ui/screen/popular_group.dart';
import '../../feature/main_profile/ui/screen/profile.dart';
import '../../feature/main_profile/ui/screen/settings.dart';
import '../../feature/main_profile/ui/screen/test_result_check.dart';

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
  static const String chatDetail = '/chat-detail';

  static const String communityMain = '/community-main';
  static const String couponList = '/coupon-list';
  static const String datingMain = '/dating-main';
  static const String historyGroupList = '/history-group-list';
  static const String hostHistoryGroupList = '/host-history-group-list';
  static const String groupScreen = '/group-screen';
  static const String mainScreen = '/main-screen';
  static const String popularGroup = '/popular-group';
  static const String userProfile = '/user-profile';
  static const String recentlyOpenGroup = '/recently-open-group';
  static const String settings = '/settings';
  static const String testResultCheck = '/test-result-check';
  static const String testResultReport = '/test-result-report';
  static const String pastApplyList = '/past-apply-list';



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
    chat,
    communityMain,
    couponList,
    datingMain,
    historyGroupList,
    hostHistoryGroupList,
    groupScreen,
    mainScreen,
    popularGroup,
    userProfile,
    recentlyOpenGroup,
    settings,
    testResultCheck,
    testResultReport,
    pastApplyList,
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
    GoRoute(
      path: '${AppRoutes.chatDetail}/:chatRoomId/:opponentNickname',
      name: 'chat-detail',
      builder: (context, state) => ChatDetailScreen(
        chatRoomId: state.pathParameters['chatRoomId']!,
        opponentNickname: state.pathParameters['opponentNickname']!,
      ),
    ),
    GoRoute(
      path: AppRoutes.communityMain,
      name: 'community-main',
      builder: (context, state) => CommunityMain(),
    ),
    GoRoute(
      path: AppRoutes.couponList,
      name: 'coupon-list',
      builder: (context, state) => CouponList(),
    ),
    GoRoute(
      path: AppRoutes.datingMain,
      name: 'dating-main',
      builder: (context, state) => const DatingMain(),
    ),
    GoRoute(
      path: AppRoutes.historyGroupList,
      name: 'history-group-list',
      builder: (context, state) => HistoryGroupList(),
    ),
    GoRoute(
      path: AppRoutes.hostHistoryGroupList,
      name: 'host-history-group-list',
      builder: (context, state) => HostHistoryGroupList(),
    ),
    GoRoute(
      path: AppRoutes.groupScreen,
      name: 'group-screen',
      builder: (context, state) => GroupScreen(),
    ),
    GoRoute(
      path: AppRoutes.mainScreen,
      name: 'main-screen',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.popularGroup,
      name: 'popular-group',
      builder: (context, state) => PopularGroupsScreen(groups: dummyPopularGroups),
    ),
    GoRoute(
      path: AppRoutes.userProfile,
      name: 'user-profile',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: AppRoutes.recentlyOpenGroup,
      name: 'recently-open-group',
      builder: (context, state) => RecentlyOpenGroupScreen(groups: dummyRecentlyOpenGroups),
    ),
    GoRoute(
      path: AppRoutes.settings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.testResultCheck,
      name: 'test-result-check',
      builder: (context, state) => TestResultCheck(answers: dummyAnswers),
    ),
    GoRoute(
      path: AppRoutes.testResultReport,
      name: 'test-result-report',
      builder: (context, state) => TestResultReport(report: dummyReport),
    ),
    GoRoute(
      path: AppRoutes.pastApplyList,
      name: 'past-apply-list',
      builder: (context, state) => const PastApplyList(),
    ),
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

