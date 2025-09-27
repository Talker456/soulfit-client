import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/di/provider.dart';
import '../../data/models/comment_model.dart';

// 댓글 목록을 관리하는 Provider
final commentListProvider = StateNotifierProvider.family<
    CommentListNotifier,
    AsyncValue<List<CommentModel>>,
    String
>((ref, postId) {
  final getCommentsUseCase = ref.watch(getCommentsUseCaseProvider);
  final createCommentUseCase = ref.watch(createCommentUseCaseProvider);

  return CommentListNotifier(
    postId: postId,
    getCommentsUseCase: getCommentsUseCase,
    createCommentUseCase: createCommentUseCase,
  );
});

class CommentListNotifier extends StateNotifier<AsyncValue<List<CommentModel>>> {
  final String postId;
  final dynamic getCommentsUseCase;
  final dynamic createCommentUseCase;

  CommentListNotifier({
    required this.postId,
    required this.getCommentsUseCase,
    required this.createCommentUseCase,
  }) : super(const AsyncValue.loading()) {
    loadComments();
  }

  // 댓글 목록 로드
  Future<void> loadComments() async {
    state = const AsyncValue.loading();
    try {
      final comments = await getCommentsUseCase(postId);
      final commentModels = comments.map<CommentModel>((comment) {
        if (comment is CommentModel) return comment;
        return CommentModel(
          id: comment.id,
          postId: comment.postId,
          author: comment.author,
          content: comment.content,
          createdAt: comment.createdAt,
        );
      }).toList();
      state = AsyncValue.data(commentModels);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  // 댓글 추가
  Future<void> addComment(String content) async {
    try {
      final newComment = await createCommentUseCase(
        postId: postId,
        content: content,
      );

      state.when(
        data: (comments) {
          final newCommentModel = newComment is CommentModel ? newComment : CommentModel(
            id: newComment.id,
            postId: newComment.postId,
            author: newComment.author,
            content: newComment.content,
            createdAt: newComment.createdAt,
          );
          state = AsyncValue.data([...comments, newCommentModel]);
        },
        loading: () {},
        error: (_, __) {},
      );
    } catch (error) {
      // 에러 처리
    }
  }
}