// lib/feature/community/presentation/riverpod/community_filter_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post_model.dart';
import 'community_filter_types.dart';
import 'community_post_provider.dart';

final filteredSortedPostsProvider = Provider<List<PostModel>>((ref) {
  final allPosts = ref.watch(postListProvider);
  final selectedPostType = ref.watch(postTypeProvider); // 모임 or 번개
  final selectedSortType = ref.watch(sortTypeProvider); // 인기순 or 최신순

  // 게시판 필터링
  final filtered = allPosts
      .where((post) => post.postType == selectedPostType.name)
      .toList();

  // 정렬
  switch (selectedSortType) {
    case SortType.popular:
      filtered.sort((a, b) => b.likeCount.compareTo(a.likeCount)); // 하트 많은 순
      break;
    case SortType.recent:
      filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // 최신순
      break;
  }

  return filtered;
});

final postTypeProvider = StateProvider<PostType>((ref) => PostType.meeting);
final sortTypeProvider = StateProvider<SortType>((ref) => SortType.recent);
