import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/paginated_posts_model.dart';

// Community Remote DataSource Interface
abstract class CommunityRemoteDataSource {
  /// 포스트 작성
  Future<PostModel> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  });

  /// 포스트 목록 조회
  Future<PaginatedPostsModel> getPosts({
    required int page,
    required int size,
    String? postType,
  });

  /// 포스트 상세 조회
  Future<PostModel> getPost(String postId);

  /// 댓글 작성
  Future<CommentModel> createComment({
    required String postId,
    required String content,
  });

  /// 댓글 목록 조회
  Future<List<CommentModel>> getComments(String postId);

  /// 포스트 좋아요
  Future<void> likePost(String postId);

  /// 포스트 좋아요 취소
  Future<void> unlikePost(String postId);
}
