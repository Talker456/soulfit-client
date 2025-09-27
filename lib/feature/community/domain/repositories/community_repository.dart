import '../entities/post.dart';
import '../entities/comment.dart';

abstract class CommunityRepository {
  Future<List<Post>> getPosts();
  Future<Post> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  });
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);

  Future<List<Comment>> getComments(String postId);
  Future<Comment> createComment({
    required String postId,
    required String content,
  });
}