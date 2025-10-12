import '../../domain/entities/comment.dart';

// Comment Model
class CommentModel extends Comment {
  const CommentModel({
    required super.id,
    required super.postId,
    required super.author,
    required super.content,
    required super.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] as String? ?? '',
      postId: json['postId'] as String? ?? '',
      author: json['author'] as String? ?? '',
      content: json['content'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'author': author,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
      };
}
