import '../entities/post.dart';
import '../repositories/community_repository.dart';

class GetPostsUseCase {
  final CommunityRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<Post>> call() async {
    return await repository.getPosts();
  }
}