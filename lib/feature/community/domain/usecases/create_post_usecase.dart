import '../repositories/community_repository.dart';
import '../entities/post.dart';

// 포스트 작성 UseCase
class CreatePostUseCase {
  final CommunityRepository repository;

  CreatePostUseCase({required this.repository});

  Future<Post> call({
    required String content,
    String? imageUrl,
    required String postType,
  }) async {
    return await repository.createPost(
      content: content,
      imageUrl: imageUrl,
      postType: postType,
    );
  }
}
