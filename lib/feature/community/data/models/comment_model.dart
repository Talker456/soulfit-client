import '../../domain/entities/comment.dart';

class CommentModel extends Comment {
  const CommentModel({
    required String id,
    required String postId,
    required String author,
    required String content,
    required DateTime createdAt,
  }) : super(
          id: id,
          postId: postId,
          author: author,
          content: content,
          createdAt: createdAt,
        );

  CommentModel copyWith({
    String? id,
    String? postId,
    String? author,
    String? content,
    DateTime? createdAt,
  }) {
    return CommentModel(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      author: author ?? this.author,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      author: json['author'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'author': author,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}