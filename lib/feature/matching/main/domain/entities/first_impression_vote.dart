class FirstImpressionVote {
  final int id;
  final int creatorId;
  final String creatorUsername;
  final String title;
  final String? creatorProfileImageUrl;
  final bool isRead;

  const FirstImpressionVote({
    required this.id,
    required this.creatorId,
    required this.creatorUsername,
    required this.title,
    this.creatorProfileImageUrl,
    this.isRead = false,
  });

  FirstImpressionVote copyWith({
    int? id,
    int? creatorId,
    String? creatorUsername,
    String? title,
    String? creatorProfileImageUrl,
    bool? isRead,
  }) {
    return FirstImpressionVote(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorUsername: creatorUsername ?? this.creatorUsername,
      title: title ?? this.title,
      creatorProfileImageUrl: creatorProfileImageUrl ?? this.creatorProfileImageUrl,
      isRead: isRead ?? this.isRead,
    );
  }
}