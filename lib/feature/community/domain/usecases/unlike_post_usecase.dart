import '../repositories/community_repository.dart';

class UnlikePostUseCase {
  final CommunityRepository repository;

  UnlikePostUseCase(this.repository);

  Future<void> call(String postId) async {
    await repository.unlikePost(postId);
  }
}