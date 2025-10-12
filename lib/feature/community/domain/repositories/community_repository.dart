import '../entities/post.dart';
import '../entities/comment.dart';
import '../entities/paginated_posts.dart';

// Community Repository Interface
abstract class CommunityRepository {
  /// 포스트 작성
  Future<Post> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  });

  /// 포스트 목록 조회
  Future<PaginatedPosts> getPosts({
    required int page,
    required int size,
    String? postType,
  });

  /// 포스트 상세 조회
  Future<Post> getPost(String postId);

  /// 댓글 작성
  Future<Comment> createComment({
    required String postId,
    required String content,
  });

  /// 댓글 목록 조회
  Future<List<Comment>> getComments(String postId);

  /// 포스트 좋아요
  Future<void> likePost(String postId);

  /// 포스트 좋아요 취소
  Future<void> unlikePost(String postId);
}
