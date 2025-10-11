import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import 'package:soulfit_client/feature/authentication/presentation/screens/find_id_screen.dart';
import 'package:soulfit_client/feature/matching/filter/presentation/screen/dating_filter.dart';
import 'package:soulfit_client/feature/matching/voting/presentation/screen/vote_create_screen.dart';
import 'package:soulfit_client/feature/matching/voting/presentation/screen/vote_participate_screen.dart';
import 'package:soulfit_client/feature/matching/voting/presentation/screen/vote_result_screen.dart';
import 'package:soulfit_client/feature/meeting/review/presentation/screen/group_review.dart';
import 'package:soulfit_client/feature/meeting/review/presentation/screen/host_review.dart';
import 'package:soulfit_client/feature/main_profile/ui/screen/main_profile_screen.dart';
import 'package:soulfit_client/feature/meeting/main/ui/screen/meeting_home_screen.dart';
import 'package:soulfit_client/feature/notification/presentation/ui/notification_screen.dart';
import 'package:soulfit_client/feature/survey/presentation/screens/life_survey_screen.dart';
import 'package:soulfit_client/feature/survey/presentation/screens/love_survey_screen.dart';
import 'package:soulfit_client/feature/meeting/application/ui/screen/meeting_application_screen.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/screen/chat_room_screen.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/screen/participants_screen.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/screen/room_list_screen.dart';

import '../../core/dev/sandbox_screen.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/screens/login_screen.dart';
import '../../feature/authentication/presentation/screens/register_screen.dart';
import '../../feature/community/presentation/screens/community_screen.dart';
import '../../feature/community/presentation/screens/create_post_screen.dart';
import '../../feature/main_profile/ui/screen/past_apply_list.dart';
import '../../feature/main_profile/ui/screen/test_result_report.dart';
import '../../feature/matching/chat-detail/presentation/screen/chat_detail_screen.dart';
import '../../feature/matching/chat/presentation/screen/chat_screen.dart';
import '../../feature/matching/chat/presentation/screen/chat_detail_screen.dart';
import '../../feature/meeting/main/ui/screen/meeting_list_screen.dart';
import '../../feature/meeting/main/ui/screen/meeting_detail_screen.dart';
import '../../feature/meeting/main/ui/screen/recently_open_group.dart';
import '../../feature/payment/presentation/ui/portone_delegator.dart';
import '../../feature/payment/presentation/ui/tosspayments_widget_v2.dart';
import '../../feature/meeting/meeting_opening/ui/screen/create_meeting_wizard_screen.dart';
import '../../feature/meeting/meeting_post/ui/screen/meeting_post_screen.dart';
import '../../feature/main_profile/meeting_dashboard/presentation/screen/meeting_dashboard_screen.dart';
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
  static const String meetingOpening = '/meeting-opening';
  static const String meetingPost = '/meeting-post';
  static const String meetingApplication = '/meeting-application';
  static const String meetingCommunity = '/meeting-community';

  static const String meetingChat = '/meeting-chat';
  static const String meetingChatRoom = '/meeting-chat-roomId';
  static const String meetingChatParticipants = '/meeting-chat-participants';

  static const String chat = '/chat';
  static const String dummyChatDetail = '/dummy-chat-detail';
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
  static const String datingFilter = '/dating-filter';
  static const String voteCreate = '/vote-create';
  static const String voteParticipate = '/vote-participate';
  static const String voteResult = '/vote-result';
  static const String groupReview = '/group-review';
  static const String hostReview = '/host-review';
  static const String meetingDashboard = '/meeting-dashboard';

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
    datingFilter,
    voteCreate,
    voteParticipate,
    voteResult,
    groupReview,
    hostReview,
    meetingOpening,
    meetingPost,
    meetingApplication,
    meetingChat,
    meetingChatRoom,
    meetingChatParticipants,
    meetingDashboard,
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
      builder:
          (context, state) => MainProfileScreen(
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
      builder:
          (context, state) =>
              MeetingListScreen(listType: state.pathParameters['listType']!),
    ),
    GoRoute(
      path: '/meeting-detail/:meetingId',
      name: 'meeting-detail',
      builder:
          (context, state) => MeetingDetailScreen(
            meetingId: state.pathParameters['meetingId']!,
          ),
    ),
    GoRoute(
      path: AppRoutes.meetingOpening,
      name: 'meeting-opening',
      builder: (context, state) => const CreateMeetingWizardScreen(),
    ),
    GoRoute(
      path: AppRoutes.meetingPost,
      name: 'meeting-post',
      builder: (context, state) => const MeetingPostScreen(postId: 'demo'),
    ),
    GoRoute(
      path: AppRoutes.meetingApplication,
      name: 'meeting-application',
      builder: (context, state) => const MeetingJoinQuestionScreen(),
    ),
    GoRoute(
      path: AppRoutes.meetingChat,
      name: 'meeting-chat',
      builder: (context, state) => const RoomListScreen(),
      routes: [
        GoRoute(
          path: ':roomId',
          name: 'meeting-chat-room',
          builder: (context, state) {
            final roomId = state.pathParameters['roomId']!;
            final title = state.uri.queryParameters['title'] ?? '';
            return ChatRoomScreen(roomId: roomId, title: title);
          },
          routes: [
            // 참가자 목록 (/meeting-chat/:roomId/participants)
            GoRoute(
              path: AppRoutes.meetingChatParticipants,
              name: 'meeting-chat-participants',
              builder: (context, state) {
                final roomId = state.pathParameters['roomId']!;
                return ParticipantsScreen(roomId: roomId);
              },
            ),
          ],
        ),
      ],
    ),
    // GoRoute(
    //   path: AppRoutes.conversation_received,
    //   name: 'conversation-received',
    //   builder: (context, state) => const ReceivedConversationRequestScreen(),
    // ),
    GoRoute(
      path: '${AppRoutes.dummyChatDetail}/:chatRoomId/:opponentNickname',
      name: 'dummy-chat-detail',
      builder:
          (context, state) => DummyChatDetailScreen(
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
      builder:
          (context, state) => PopularGroupsScreen(groups: dummyPopularGroups),
    ),
    GoRoute(
      path: AppRoutes.userProfile,
      name: 'user-profile',
      builder: (context, state) => const Profile(),
    ),
    GoRoute(
      path: AppRoutes.recentlyOpenGroup,
      name: 'recently-open-group',
      builder:
          (context, state) =>
              RecentlyOpenGroupScreen(groups: dummyRecentlyOpenGroups),
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
    GoRoute(
      path: '${AppRoutes.chatDetail}/:chatRoomId/:opponentNickname',
      name: 'chat-detail',
      builder:
          (context, state) => ChatDetailScreen(
            roomId: state.pathParameters['chatRoomId']!,
            opponentNickname: state.pathParameters['opponentNickname']!,
          ),
    ),
    GoRoute(
      path: AppRoutes.datingFilter,
      name: 'dating-filter',
      builder: (context, state) => const DatingFilterScreen(),
    ),
    GoRoute(
      path: AppRoutes.voteCreate,
      name: 'vote-create',
      builder: (context, state) => const VoteCreateScreen(),
    ),
    GoRoute(
      path: '${AppRoutes.voteParticipate}/:voteFormId',
      name: 'vote-participate',
      builder: (context, state) {
        final voteFormId = int.parse(state.pathParameters['voteFormId']!);
        return VoteParticipateScreen(voteFormId: voteFormId);
      },
    ),
    GoRoute(
      path: '${AppRoutes.voteResult}/:voteFormId',
      name: 'vote-result',
      builder: (context, state) {
        final voteFormId = int.parse(state.pathParameters['voteFormId']!);
        return VoteResultScreen(voteFormId: voteFormId);
      },
    ),
    GoRoute(
      path: AppRoutes.groupReview,
      name: 'group-review',
      builder: (context, state) => const GroupReview(),
    ),
    GoRoute(
      path: AppRoutes.hostReview,
      name: 'host-review',
      builder: (context, state) => const HostReview(),
    ),
    GoRoute(
      path: AppRoutes.meetingDashboard,
      name: 'meeting-dashboard',
      builder: (context, state) => const MeetingDashboardScreen(),
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
                return Consumer(
                  builder: (context, ref, child) {
                    final userId = ref.watch(
                      authNotifierProvider.select((value) => value.user?.id),
                    );
                    if (userId == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return MainProfileScreen(
                      viewerUserId: userId,
                      targetUserId: userId,
                    );
                  },
                );
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
