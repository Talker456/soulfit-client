import '../repositories/community_repository.dart';
import '../entities/paginated_posts.dart';

// 포스트 목록 조회 UseCase
class GetPostsUseCase {
  final CommunityRepository repository;

  GetPostsUseCase({required this.repository});

  Future<PaginatedPosts> call({
    required int page,
    required int size,
    String? postType,
  }) async {
    return await repository.getPosts(
      page: page,
      size: size,
      postType: postType,
    );
  }
}
