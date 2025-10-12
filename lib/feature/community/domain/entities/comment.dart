// 댓글 Entity
class Comment {
  final String id;
  final String postId;
  final String author;
  final String content;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.postId,
    required this.author,
    required this.content,
    required this.createdAt,
  });
}
