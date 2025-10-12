import '../repositories/community_repository.dart';

// 포스트 좋아요/취소 UseCase
class LikePostUseCase {
  final CommunityRepository repository;

  LikePostUseCase({required this.repository});

  Future<void> like(String postId) async {
    return await repository.likePost(postId);
  }

  Future<void> unlike(String postId) async {
    return await repository.unlikePost(postId);
  }
}
