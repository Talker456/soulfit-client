// lib/feature/community/presentation/riverpod/community_post_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/provider.dart';
import '../../data/models/post_model.dart';
import '../../domain/entities/post.dart';

// 게시글 목록 전체를 관리하는 Provider
final postListProvider =
    StateNotifierProvider<PostListNotifier, AsyncValue<List<PostModel>>>((ref) {
      final getPostsUseCase = ref.watch(getPostsUseCaseProvider);
      final createPostUseCase = ref.watch(createPostUseCaseProvider);
      final likePostUseCase = ref.watch(likePostUseCaseProvider);
      final unlikePostUseCase = ref.watch(unlikePostUseCaseProvider);

      return PostListNotifier(
        getPostsUseCase: getPostsUseCase,
        createPostUseCase: createPostUseCase,
        likePostUseCase: likePostUseCase,
        unlikePostUseCase: unlikePostUseCase,
      );
    });

class PostListNotifier extends StateNotifier<AsyncValue<List<PostModel>>> {
  final dynamic getPostsUseCase;
  final dynamic createPostUseCase;
  final dynamic likePostUseCase;
  final dynamic unlikePostUseCase;

  PostListNotifier({
    required this.getPostsUseCase,
    required this.createPostUseCase,
    required this.likePostUseCase,
    required this.unlikePostUseCase,
  }) : super(const AsyncValue.loading()) {
    loadPosts();
  }

  // 게시글 목록 로드
  Future<void> loadPosts() async {
    state = const AsyncValue.loading();
    try {
      final posts = await getPostsUseCase();
      final postModels = posts.map<PostModel>((post) {
        if (post is PostModel) return post;
        return PostModel(
          id: post.id,
          author: post.author,
          content: post.content,
          imageUrl: post.imageUrl,
          postType: post.postType,
          likeCount: post.likeCount,
          commentCount: post.commentCount,
          bookmarkCount: post.bookmarkCount,
          createdAt: post.createdAt,
          isLiked: post.isLiked,
          isBookmarked: post.isBookmarked,
        );
      }).toList();
      state = AsyncValue.data(postModels);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  // 게시글 추가
  Future<void> addPost({
    required String content,
    String? imageUrl,
    required String postType,
  }) async {
    try {
      final newPost = await createPostUseCase(
        content: content,
        imageUrl: imageUrl,
        postType: postType,
      );

      state.when(
        data: (posts) {
          final newPostModel = newPost is PostModel ? newPost : PostModel(
            id: newPost.id,
            author: newPost.author,
            content: newPost.content,
            imageUrl: newPost.imageUrl,
            postType: newPost.postType,
            likeCount: newPost.likeCount,
            commentCount: newPost.commentCount,
            bookmarkCount: newPost.bookmarkCount,
            createdAt: newPost.createdAt,
            isLiked: newPost.isLiked,
            isBookmarked: newPost.isBookmarked,
          );
          state = AsyncValue.data([newPostModel, ...posts]);
        },
        loading: () {},
        error: (_, __) {},
      );
    } catch (error) {
      // 에러 처리
    }
  }

  // 좋아요 토글
  Future<void> toggleLike(String postId) async {
    state.when(
      data: (posts) {
        final post = posts.firstWhere((p) => p.id == postId);

        if (post.isLiked) {
          _unlikePost(postId);
        } else {
          _likePost(postId);
        }
      },
      loading: () {},
      error: (_, __) {},
    );
  }

  Future<void> _likePost(String postId) async {
    try {
      await likePostUseCase(postId);

      state.when(
        data: (posts) {
          final updatedPosts = posts.map((post) {
            if (post.id == postId) {
              return post.copyWith(
                isLiked: true,
                likeCount: post.likeCount + 1,
              );
            }
            return post;
          }).toList();
          state = AsyncValue.data(updatedPosts);
        },
        loading: () {},
        error: (_, __) {},
      );
    } catch (error) {
      // 에러 처리
    }
  }

  Future<void> _unlikePost(String postId) async {
    try {
      await unlikePostUseCase(postId);

      state.when(
        data: (posts) {
          final updatedPosts = posts.map((post) {
            if (post.id == postId) {
              return post.copyWith(
                isLiked: false,
                likeCount: post.likeCount - 1,
              );
            }
            return post;
          }).toList();
          state = AsyncValue.data(updatedPosts);
        },
        loading: () {},
        error: (_, __) {},
      );
    } catch (error) {
      // 에러 처리
    }
  }

  // 북마크 토글 (로컬 상태만 변경)
  void toggleBookmark(String postId) {
    state.when(
      data: (posts) {
        final updatedPosts = posts.map((post) {
          if (post.id == postId) {
            return post.copyWith(
              isBookmarked: !post.isBookmarked,
              bookmarkCount: post.isBookmarked
                  ? post.bookmarkCount - 1
                  : post.bookmarkCount + 1,
            );
          }
          return post;
        }).toList();
        state = AsyncValue.data(updatedPosts);
      },
      loading: () {},
      error: (_, __) {},
    );
  }
}
