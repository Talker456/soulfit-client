// lib/feature/community/presentation/riverpod/community_post_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post_model.dart';

// 게시글 목록 전체를 관리하는 Provider
final postListProvider =
    StateNotifierProvider<PostListNotifier, List<PostModel>>((ref) {
      return PostListNotifier();
    });

class PostListNotifier extends StateNotifier<List<PostModel>> {
  PostListNotifier() : super([]);

  // 게시글 추가
  void addPost(PostModel post) {
    state = [post, ...state];
  }

  // 좋아요 토글
  void toggleLike(String postId) {
    state = [
      for (final post in state)
        if (post.id == postId)
          post.copyWith(
            isLiked: !post.isLiked,
            likeCount: post.isLiked ? post.likeCount - 1 : post.likeCount + 1,
          )
        else
          post,
    ];
  }

  // 북마크 토글
  void toggleBookmark(String postId) {
    state = [
      for (final post in state)
        if (post.id == postId)
          post.copyWith(
            isBookmarked: !post.isBookmarked,
            bookmarkCount: post.isBookmarked
                ? post.bookmarkCount - 1
                : post.bookmarkCount + 1,
          )
        else
          post,
    ];
  }
}
