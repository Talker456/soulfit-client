import '../models/post_model.dart';
import '../models/comment_model.dart';

abstract class CommunityRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  });
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);

  Future<List<CommentModel>> getComments(String postId);
  Future<CommentModel> createComment({
    required String postId,
    required String content,
  });
}