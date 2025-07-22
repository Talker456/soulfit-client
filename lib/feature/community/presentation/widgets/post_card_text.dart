// lib/feature/community/presentation/widgets/post_card_text.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post_model.dart';
import '../riverpod/community_post_provider.dart';

class PostCardText extends ConsumerWidget {
  final PostModel post;

  const PostCardText({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.author,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(post.content),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.chat_bubble_outline, size: 18),
                Text(' ${post.commentCount}'),
                const SizedBox(width: 12),

                // ❤️ 좋아요
                IconButton(
                  icon: Icon(
                    post.isLiked ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                    color: Colors.pink,
                  ),
                  onPressed: () {
                    ref.read(postListProvider.notifier).toggleLike(post.id);
                  },
                ),
                Text(' ${post.likeCount}'),

                const SizedBox(width: 12),

                // ⭐️ 북마크
                IconButton(
                  icon: Icon(
                    post.isBookmarked ? Icons.star : Icons.star_border,
                    size: 18,
                  ),
                  onPressed: () {
                    ref.read(postListProvider.notifier).toggleBookmark(post.id);
                  },
                ),
                Text(' ${post.bookmarkCount}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
