// lib/feature/community/data/models/post_model.dart

import '../../domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required String id,
    required String author,
    required String content,
    required String? imageUrl,
    required String postType,
    required int likeCount,
    required int commentCount,
    required int bookmarkCount,
    required DateTime createdAt,
    bool isLiked = false,
    bool isBookmarked = false,
  }) : super(
         id: id,
         author: author,
         content: content,
         imageUrl: imageUrl,
         postType: postType,
         likeCount: likeCount,
         commentCount: commentCount,
         bookmarkCount: bookmarkCount,
         createdAt: createdAt,
         isLiked: isLiked,
         isBookmarked: isBookmarked,
       );

  PostModel copyWith({
    String? id,
    String? author,
    String? content,
    String? imageUrl,
    String? postType,
    int? likeCount,
    int? commentCount,
    int? bookmarkCount,
    DateTime? createdAt,
    bool? isLiked,
    bool? isBookmarked,
  }) {
    return PostModel(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      postType: postType ?? this.postType,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
      createdAt: createdAt ?? this.createdAt,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      author: json['author'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      postType: json['postType'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      bookmarkCount: json['bookmarkCount'],
      createdAt: DateTime.parse(json['createdAt']),
      isLiked: json['isLiked'] ?? false,
      isBookmarked: json['isBookmarked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'content': content,
      'imageUrl': imageUrl,
      'postType': postType,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'bookmarkCount': bookmarkCount,
      'createdAt': createdAt.toIso8601String(),
      'isLiked': isLiked,
      'isBookmarked': isBookmarked,
    };
  }
}
