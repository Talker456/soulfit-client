// lib/feature/community/presentation/screens/community_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/filter_tab_bar.dart';
import '../widgets/post_list_view.dart';
import '../riverpod/nav_index_provider.dart';
import 'create_post_screen.dart';
import 'package:go_router/go_router.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(navIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('soulfit'),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 12),
          Icon(Icons.notifications_none),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          const FilterTabBar(),
          const Divider(height: 1),
          const Expanded(child: PostListView()),
          const SizedBox(height: 16),

          // 임시 테스트 버튼들
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/life-survey'); // 인생 가치관 검사 이동
                    },
                    child: const Text('인생 가치관 검사 시작'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.push('/love-survey-intro'); // 연애 가치관 검사 이동
                    },
                    child: const Text('연애 가치관 검사 시작'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePostScreen()),
          );
        },
        backgroundColor: const Color(0x3881E06E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: const BorderSide(color: Color(0xFF66A825), width: 1.5),
        ),
        child: const Icon(Icons.add, color: Color(0xFF66A825)),
      ),
    );
  }
}
