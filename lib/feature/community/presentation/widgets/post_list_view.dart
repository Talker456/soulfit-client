// lib/feature/community/presentation/widgets/post_list_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/community_filter_provider.dart'; // 여기서 필터된 글 불러옴
import '../riverpod/community_filter_types.dart'; // PostType enum
import 'post_card_photo.dart';
import 'post_card_text.dart';

class PostListView extends ConsumerWidget {
  const PostListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 필터 + 정렬된 게시글 목록 가져오기
    final posts = ref.watch(filteredSortedPostsProvider);
    final postType = ref.watch(postTypeProvider);

    if (posts.isEmpty) {
      return const Center(child: Text('게시글이 없습니다.'));
    }

    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        // 게시판 타입에 따라 카드 UI 다르게
        if (postType == PostType.meeting) {
          return PostCardPhoto(post: post);
        } else {
          return PostCardText(post: post);
        }
      },
    );
  }
}
