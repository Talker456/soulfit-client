import '../repositories/community_repository.dart';

class LikePostUseCase {
  final CommunityRepository repository;

  LikePostUseCase(this.repository);

  Future<void> call(String postId) async {
    await repository.likePost(postId);
  }
}