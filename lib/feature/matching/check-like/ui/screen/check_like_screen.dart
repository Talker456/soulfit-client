import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../provider/check_like_providers.dart';
import '../notifier/check_like_notifier.dart';
import '../widgets/user_bubble.dart';
import 'package:soulfit_client/config/router/app_router.dart';

class CheckLikeScreen extends ConsumerWidget {
  const CheckLikeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkLikeNotifierProvider);
    final notifier = ref.read(checkLikeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.tab == LikeTab.likedMe ? '나를 좋아하는 사람들' : '내가 좋아하는 사람들',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            // Removed filter chips and sub-tabs as per plan.

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ChoiceChip(
                    label: const Text('나를 좋아하는 사람들'),
                    selected: state.tab == LikeTab.likedMe,
                    onSelected: (_) => notifier.switchTab(LikeTab.likedMe),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('내가 좋아하는 사람들'),
                    selected: state.tab == LikeTab.iLike,
                    onSelected: (_) => notifier.switchTab(LikeTab.iLike),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEEF5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Builder(
                  builder: (_) {
                    if (state.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.error != null) {
                      return Center(child: Text('오류: ${state.error}'));
                    }
                    if (state.users.isEmpty) {
                      return const Center(child: Text('표시할 사용자가 없어요.'));
                    }
                    return GridView.builder(
                      itemCount: state.users.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                      itemBuilder: (ctx, i) {
                        final u = state.users[i];
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            UserBubble(avatarUrl: u.avatarUrl),
                            const SizedBox(height: 6),
                            Text(
                              u.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton:
          state.tab == LikeTab.likedMe
              ? FloatingActionButton.extended(
                onPressed: () {
                  context.push(AppRoutes.swipeLike);
                },
                label: const Text('스와이프 하러가기'),
                icon: const Icon(Icons.favorite),
              )
              : null,
    );
  }
}
