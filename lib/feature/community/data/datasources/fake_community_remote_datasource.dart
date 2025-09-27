import '../models/post_model.dart';
import '../models/comment_model.dart';
import 'community_remote_datasource.dart';

class FakeCommunityRemoteDataSource implements CommunityRemoteDataSource {
  static int _postIdCounter = 1;
  static int _commentIdCounter = 1;

  final List<PostModel> _posts = [
    PostModel(
      id: '1',
      author: '사용자1',
      content: '첫 번째 게시물입니다!',
      imageUrl: null,
      postType: 'general',
      likeCount: 5,
      commentCount: 2,
      bookmarkCount: 1,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isLiked: false,
      isBookmarked: false,
    ),
    PostModel(
      id: '2',
      author: '사용자2',
      content: '오늘 날씨가 좋네요~',
      imageUrl: 'https://example.com/image.jpg',
      postType: 'general',
      likeCount: 12,
      commentCount: 5,
      bookmarkCount: 3,
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      isLiked: true,
      isBookmarked: false,
    ),
  ];

  final List<CommentModel> _comments = [
    CommentModel(
      id: '1',
      postId: '1',
      author: '댓글작성자1',
      content: '좋은 글이네요!',
      createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    CommentModel(
      id: '2',
      postId: '1',
      author: '댓글작성자2',
      content: '동감합니다~',
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
  ];

  @override
  Future<List<PostModel>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_posts);
  }

  @override
  Future<PostModel> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final newPost = PostModel(
      id: (_postIdCounter++).toString(),
      author: '현재사용자',
      content: content,
      imageUrl: imageUrl,
      postType: postType,
      likeCount: 0,
      commentCount: 0,
      bookmarkCount: 0,
      createdAt: DateTime.now(),
      isLiked: false,
      isBookmarked: false,
    );

    _posts.insert(0, newPost);
    return newPost;
  }

  @override
  Future<void> likePost(String postId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(
        isLiked: true,
        likeCount: post.likeCount + 1,
      );
    }
  }

  @override
  Future<void> unlikePost(String postId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(
        isLiked: false,
        likeCount: post.likeCount - 1,
      );
    }
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _comments.where((comment) => comment.postId == postId).toList();
  }

  @override
  Future<CommentModel> createComment({
    required String postId,
    required String content,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final newComment = CommentModel(
      id: (_commentIdCounter++).toString(),
      postId: postId,
      author: '현재사용자',
      content: content,
      createdAt: DateTime.now(),
    );

    _comments.add(newComment);

    final postIndex = _posts.indexWhere((post) => post.id == postId);
    if (postIndex != -1) {
      final post = _posts[postIndex];
      _posts[postIndex] = post.copyWith(
        commentCount: post.commentCount + 1,
      );
    }

    return newComment;
  }
}