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

  Comment copyWith({
    String? id,
    String? postId,
    String? author,
    String? content,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}