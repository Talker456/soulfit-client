// lib/feature/community/presentation/riverpod/post_upload_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/post_model.dart';
import 'community_post_provider.dart';

final postUploadProvider = Provider<PostUploadService>((ref) {
  return PostUploadService(ref);
});

class PostUploadService {
  final Ref ref;

  PostUploadService(this.ref);

  Future<void> uploadPost({
    required String title,
    required String content,
    required String board,
    required List<String> imageUrls,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500)); // 가짜 딜레이

    final newPost = PostModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      author: '나',
      content: content,
      imageUrl: imageUrls.isNotEmpty ? imageUrls.first : null,
      postType: board == '번개모임' ? '번개' : '모임',
      likeCount: 0,
      commentCount: 0,
      bookmarkCount: 0,
      createdAt: DateTime.now(),
    );

    ref.read(postListProvider.notifier).addPost(newPost);
  }
}
