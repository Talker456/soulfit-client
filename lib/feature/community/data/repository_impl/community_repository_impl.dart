import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../../domain/repositories/community_repository.dart';
import '../datasources/community_remote_datasource.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;

  CommunityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Post>> getPosts() async {
    return await remoteDataSource.getPosts();
  }

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
  Future<void> likePost(String postId) async {
    await remoteDataSource.likePost(postId);
  }

  @override
  Future<void> unlikePost(String postId) async {
    await remoteDataSource.unlikePost(postId);
  }

  @override
  Future<List<Comment>> getComments(String postId) async {
    return await remoteDataSource.getComments(postId);
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
}