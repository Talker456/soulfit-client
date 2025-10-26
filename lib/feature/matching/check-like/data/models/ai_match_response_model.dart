import '../../domain/entities/ai_match.dart';

class AiMatchResponseModel {
  final int userId;
  final String username;
  final String profileImageUrl;
  final double matchScore;
  final String matchReason;

  AiMatchResponseModel({
    required this.userId,
    required this.username,
    required this.profileImageUrl,
    required this.matchScore,
    required this.matchReason,
  });

  factory AiMatchResponseModel.fromJson(Map<String, dynamic> json) {
    final aiMatchResult = json['aiMatchResult'] as Map<String, dynamic>;
    return AiMatchResponseModel(
      userId: aiMatchResult['user_id'] as int,
      username: json['username'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
      matchScore: (aiMatchResult['match_score'] as num).toDouble(),
      matchReason: aiMatchResult['match_reason'] as String,
    );
  }

  AiMatch toEntity() => AiMatch(
        userId: userId,
        username: username,
        profileImageUrl: profileImageUrl,
        matchScore: matchScore,
        matchReason: matchReason,
      );
}
