/// 투표 폼 Entity
/// 사용자가 생성한 첫인상 투표
class VoteForm {
  final int id;
  final int creatorId;
  final String creatorUsername;
  final String title;
  final String? creatorProfileImageUrl;
  final bool isRead;
  final DateTime createdAt;

  const VoteForm({
    required this.id,
    required this.creatorId,
    required this.creatorUsername,
    required this.title,
    this.creatorProfileImageUrl,
    this.isRead = false,
    required this.createdAt,
  });

  VoteForm copyWith({
    int? id,
    int? creatorId,
    String? creatorUsername,
    String? title,
    String? creatorProfileImageUrl,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return VoteForm(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorUsername: creatorUsername ?? this.creatorUsername,
      title: title ?? this.title,
      creatorProfileImageUrl: creatorProfileImageUrl ?? this.creatorProfileImageUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
