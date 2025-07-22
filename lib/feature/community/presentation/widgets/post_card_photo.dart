// lib/feature/community/presentation/widgets/post_card_photo.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post_model.dart';
import '../riverpod/community_post_provider.dart';

class PostCardPhoto extends ConsumerWidget {
  final PostModel post;

  const PostCardPhoto({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
            Image.network(post.imageUrl!, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(post.content),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 좋아요 버튼
              IconButton(
                icon: Icon(
                  post.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: Colors.pink,
                ),
                onPressed: () {
                  ref.read(postListProvider.notifier).toggleLike(post.id);
                },
              ),
              Text('${post.likeCount}'),

              const SizedBox(width: 8),

              // 북마크 버튼
              IconButton(
                icon: Icon(
                  post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: () {
                  ref.read(postListProvider.notifier).toggleBookmark(post.id);
                },
              ),
              Text('${post.bookmarkCount}'),

              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
