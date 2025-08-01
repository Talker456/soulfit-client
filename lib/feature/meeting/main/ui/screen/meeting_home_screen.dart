import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/config/router/app_router.dart';
import '../provider/meeting_list_providers.dart';
import '../widget/event_banner.dart';
import '../widget/category_menu.dart';
import '../widget/meeting_section.dart';

class MeetingHomeScreen extends ConsumerWidget {
  const MeetingHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 앱바 스타일 헤더
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('soulfit', style: TextStyle(fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
                    Row(
                      children: const [
                        Icon(Icons.history, size: 20),
                        SizedBox(width: 12),
                        Icon(Icons.send, size: 20),
                        SizedBox(width: 12),
                        Icon(Icons.search, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // 제목
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('모임', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 12)),

            // 이벤트 광고 배너
            const SliverToBoxAdapter(child: EventBanner()),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // 카테고리 메뉴
            const SliverToBoxAdapter(child: CategoryMenu()),

            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // AI 맞춤 추천
            SliverToBoxAdapter(
              child: MeetingSection(
                title: 'AI 맞춤 추천 모임',
                provider: aiRecommendedMeetingsProvider,
                onSeeMorePressed: () {
                  context.push(AppRoutes.aiMeetingList);
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 인기 모임
            SliverToBoxAdapter(
              child: MeetingSection(
                title: '인기 모임',
                provider: popularMeetingsProvider,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 최근 개설된 모임
            SliverToBoxAdapter(
              child: MeetingSection(
                title: '최근 개설된 모임',
                provider: recentlyCreatedMeetingsProvider,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),

            // 최근 참여한 모임
            SliverToBoxAdapter(
              child: MeetingSection(
                title: '최근 참여한 모임',
                provider: userRecentJoinedMeetingsProvider,
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 36)),
          ],
        ),
      ),
    );
  }
}
