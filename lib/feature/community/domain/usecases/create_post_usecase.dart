import '../entities/post.dart';
import '../repositories/community_repository.dart';

class CreatePostUseCase {
  final CommunityRepository repository;

  CreatePostUseCase(this.repository);

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