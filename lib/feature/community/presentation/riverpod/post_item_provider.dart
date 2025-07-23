// lib/feature/community/presentation/riverpod/post_item_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post.dart';
import 'community_post_provider.dart';

class PostNotifier extends StateNotifier<Post> {
  PostNotifier(Post post) : super(post);

  void toggleLike() {
    state = state.copyWith(
      isLiked: !state.isLiked,
      likeCount: state.isLiked ? state.likeCount - 1 : state.likeCount + 1,
    );
  }

  void toggleBookmark() {
    state = state.copyWith(
      isBookmarked: !state.isBookmarked,
      bookmarkCount: state.isBookmarked
          ? state.bookmarkCount - 1
          : state.bookmarkCount + 1,
    );
  }
}

final postProvider = StateNotifierProvider.family<PostNotifier, Post, String>((
  ref,
  postId,
) {
  final post = ref.watch(postListProvider).firstWhere((p) => p.id == postId);
  return PostNotifier(post);
});
