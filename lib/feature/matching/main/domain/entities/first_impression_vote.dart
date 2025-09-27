class FirstImpressionVote {
  final String id;
  final String userId;
  final String userName;
  final String message;
  final String userProfileImageUrl;
  final DateTime createdAt;
  final bool isRead;

  const FirstImpressionVote({
    required this.id,
    required this.userId,
    required this.userName,
    required this.message,
    required this.userProfileImageUrl,
    required this.createdAt,
    this.isRead = false,
  });

  FirstImpressionVote copyWith({
    String? id,
    String? userId,
    String? userName,
    String? message,
    String? userProfileImageUrl,
    DateTime? createdAt,
    bool? isRead,
  }) {
    return FirstImpressionVote(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      message: message ?? this.message,
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
    );
  }
}