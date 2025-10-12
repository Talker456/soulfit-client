import '../repositories/community_repository.dart';
import '../entities/comment.dart';

// 댓글 작성 UseCase
class CreateCommentUseCase {
  final CommunityRepository repository;

  CreateCommentUseCase({required this.repository});

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
