import '../entities/comment.dart';
import '../repositories/community_repository.dart';

class CreateCommentUseCase {
  final CommunityRepository repository;

  CreateCommentUseCase(this.repository);

  Future<Comment> call({
    required String postId,
    required String content,
  }) async {
    return await repository.createComment(
      postId: postId,
      content: content,
    );
  }
}