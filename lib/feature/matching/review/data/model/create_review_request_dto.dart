
class CreateReviewRequestDto {
  final int revieweeId;
  final int chatRoomId;
  final String comment;
  final List<String> keywords;

  CreateReviewRequestDto({
    required this.revieweeId,
    required this.chatRoomId,
    required this.comment,
    required this.keywords,
  });

  Map<String, dynamic> toJson() {
    return {
      'revieweeId': revieweeId,
      'chatRoomId': chatRoomId,
      'comment': comment,
      'keywords': keywords,
    };
  }
}
