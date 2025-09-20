
class CreateReviewRequestDto {
  final int revieweeId;
  final int conversationRequestId;
  final String comment;
  final List<String> keywords;

  CreateReviewRequestDto({
    required this.revieweeId,
    required this.conversationRequestId,
    required this.comment,
    required this.keywords,
  });

  Map<String, dynamic> toJson() {
    return {
      'revieweeId': revieweeId,
      'conversationRequestId': conversationRequestId,
      'comment': comment,
      'keywords': keywords,
    };
  }
}
