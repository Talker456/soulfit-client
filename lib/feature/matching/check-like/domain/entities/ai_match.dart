class AiMatch {
  final int userId;
  final String username;
  final String profileImageUrl;
  final double matchScore;
  final String matchReason;

  AiMatch({
    required this.userId,
    required this.username,
    required this.profileImageUrl,
    required this.matchScore,
    required this.matchReason,
  });
}
