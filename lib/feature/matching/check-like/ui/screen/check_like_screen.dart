import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/router/app_router.dart';
import '../provider/check_like_providers.dart';
import '../notifier/check_like_notifier.dart';
import '../widgets/ai_match_loading_dialog.dart'; // Import the new loading dialog
import '../widgets/ai_match_result_dialog.dart';
import '../widgets/user_bubble.dart';
import 'package:soulfit_client/config/di/provider.dart';

class CheckLikeScreen extends ConsumerWidget {
  const CheckLikeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkLikeNotifierProvider);
    final notifier = ref.read(checkLikeNotifierProvider.notifier);
    final viewer = ref.watch(authNotifierProvider).user;

    ref.listen(checkLikeNotifierProvider.select((value) => value.aiMatchState),
        (previous, next) {
      // Dismiss any existing dialog before showing a new one or a snackbar
      if (previous != null && previous.isLoading && !next.isLoading) {
        Navigator.of(context, rootNavigator: true).pop(); // Dismiss loading dialog
      }

      next.when(
        data: (data) {
          if (data.isNotEmpty) {
            showDialog(
              context: context,
              builder: (context) => AiMatchResultDialog(matchResult: data.first, viewerId: viewer!.id),
            );
          }
        },
        loading: () {
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismissing by tapping outside
            builder: (context) => const AiMatchLoadingDialog(),
          );
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('AI 매칭 분석 중 오류가 발생했습니다: $error')),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          state.tab == LikeTab.likedMe ? '나를 좋아하는 사람들' : '내가 좋아하는 사람들',
        ),
        actions: [
          TextButton(
            onPressed: state.aiMatchState.isLoading // Disable button when loading
                ? null
                : () {
                    final candidateUserIds = state.users.map((u) => int.parse(u.id)).toList();
                    if (candidateUserIds.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('분석할 사용자가 없습니다.')),
                      );
                      return;
                    }
                    notifier.getAiMatch(candidateUserIds);
                  },
            child: const Text('AI 매칭 분석'),
          ),
        ],
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
                        return InkWell(
                          onTap: () {
                            if (viewer == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('사용자 정보를 불러올 수 없습니다.')),
                              );
                              return;
                            }
                            context.push('/dating-profile/${viewer.id}/${u.id}');
                          },
                          child: Column(
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
                          ),
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
