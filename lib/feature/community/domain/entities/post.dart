class Post {
  final String id;
  final String author;
  final String content;
  final String? imageUrl;
  final String postType;
  final int likeCount;
  final int commentCount;
  final int bookmarkCount;
  final DateTime createdAt;
  final bool isLiked;
  final bool isBookmarked;

  const Post({
    required this.id,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.postType,
    required this.likeCount,
    required this.commentCount,
    required this.bookmarkCount,
    required this.createdAt,
    this.isLiked = false,
    this.isBookmarked = false,
  });

  Post copyWith({
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
    return Post(
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
}
