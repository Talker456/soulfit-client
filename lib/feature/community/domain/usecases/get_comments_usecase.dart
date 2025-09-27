import '../entities/comment.dart';
import '../repositories/community_repository.dart';

class GetCommentsUseCase {
  final CommunityRepository repository;

  GetCommentsUseCase(this.repository);

  Future<List<Comment>> call(String postId) async {
    return await repository.getComments(postId);
  }
}