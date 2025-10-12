import '../../domain/repositories/community_repository.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/entities/paginated_posts.dart';
import '../datasources/community_remote_datasource.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;

  CommunityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Post> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  }) async {
    return await remoteDataSource.createPost(
      content: content,
      imageUrl: imageUrl,
      postType: postType,
    );
  }

  @override
  Future<PaginatedPosts> getPosts({
    required int page,
    required int size,
    String? postType,
  }) async {
    return await remoteDataSource.getPosts(
      page: page,
      size: size,
      postType: postType,
    );
  }

  @override
  Future<Post> getPost(String postId) async {
    return await remoteDataSource.getPost(postId);
  }

  @override
  Future<Comment> createComment({
    required String postId,
    required String content,
  }) async {
    return await remoteDataSource.createComment(
      postId: postId,
      content: content,
    );
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    return await remoteDataSource.getComments(postId);
  }

  @override
  Future<void> likePost(String postId) async {
    return await remoteDataSource.likePost(postId);
  }

  @override
  Future<void> unlikePost(String postId) async {
    return await remoteDataSource.unlikePost(postId);
  }
}
