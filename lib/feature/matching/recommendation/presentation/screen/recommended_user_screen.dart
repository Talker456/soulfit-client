
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import 'package:soulfit_client/feature/matching/main/domain/entities/recommended_user.dart';
import 'package:soulfit_client/feature/matching/recommendation/presentation/provider/recommended_user_provider.dart';
import 'package:soulfit_client/feature/matching/recommendation/presentation/state/recommended_user_state.dart';

import 'package:soulfit_client/config/router/app_router.dart';

import '../../../../../config/di/provider.dart';

class RecommendedUserScreen extends ConsumerStatefulWidget {
  const RecommendedUserScreen({super.key});

  @override
  ConsumerState<RecommendedUserScreen> createState() => _RecommendedUserScreenState();
}

class _RecommendedUserScreenState extends ConsumerState<RecommendedUserScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(recommendedUserNotifierProvider.notifier).fetchMoreUsers();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // 90% 지점에서 다음 페이지 로딩 시작
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(recommendedUserNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        showBackButton: true,
        title: const Text('추천 유저', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black54),
            onPressed: () {
              context.push(AppRoutes.checkLike);
            },
          ),
        ],
      ),
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: 탭 처리 구현
        },
      ),
      body: switch (state) {
        RecommendedUserLoading() => const Center(child: CircularProgressIndicator()),
        RecommendedUserError(:final message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(recommendedUserNotifierProvider.notifier).fetchInitialUsers(),
                  child: const Text('다시 시도'),
                )
              ],
            ),
          ),
        RecommendedUserLoaded(:final users, :final hasReachedMax) =>
          _buildUserGrid(users, hasReachedMax),
      },
    );
  }

  Widget _buildUserGrid(List<RecommendedUser> users, bool hasReachedMax) {
    if (users.isEmpty) {
      return const Center(child: Text('추천할 유저가 더 이상 없습니다.'));
    }
    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16.0),
      itemCount: users.length + (hasReachedMax ? 0 : 1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemBuilder: (context, index) {
        if (index >= users.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = users[index];
        return _UserCard(user: user);
      },
    );
  }
}

class _UserCard extends ConsumerWidget {
  final RecommendedUser user;
  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        final viewerId = ref.read(authNotifierProvider).user?.id;
        if (viewerId == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('사용자 정보를 불러올 수 없습니다.')),
          );
          return;
        }
        context.push('/main-profile/$viewerId/${user.userId}');
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              user.profileImageUrl ?? 'https://picsum.photos/400/600', // Fallback Image
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error, color: Colors.red));
              },
            ),
            _buildGradientOverlay(),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.nickname}, ${user.age}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: Icons.close,
                        onPressed: () => ref.read(recommendedUserNotifierProvider.notifier).swipeUser(userId: user.userId, isLike: false),
                      ),
                      _buildActionButton(
                        icon: Icons.favorite,
                        onPressed: () => ref.read(recommendedUserNotifierProvider.notifier).swipeUser(userId: user.userId, isLike: true),
                        iconColor: Colors.pinkAccent,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color iconColor = Colors.white,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.3),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}
