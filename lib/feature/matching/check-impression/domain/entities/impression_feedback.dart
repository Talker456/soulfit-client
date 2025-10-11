class ImpressionFeedback {
  final String targetUserId;
  final List<String> tagIds;
  final String comment;

  const ImpressionFeedback({
    required this.targetUserId,
    required this.tagIds,
    required this.comment,
  });
}
