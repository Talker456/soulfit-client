class SubmitFeedbackReq {
  final String targetUserId;
  final List<String> tagIds;
  final String comment;

  SubmitFeedbackReq({
    required this.targetUserId,
    required this.tagIds,
    required this.comment,
  });

  Map<String, dynamic> toJson() => {
    'target_user_id': targetUserId,
    'tag_ids': tagIds,
    'comment': comment,
  };
}
