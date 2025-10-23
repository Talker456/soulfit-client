import '../../domain/entities/ai_match.dart';

class AiMatchResponseModel {
  final int userId;
  final double matchScore;
  final String matchReason;

  AiMatchResponseModel({
    required this.userId,
    required this.matchScore,
    required this.matchReason,
  });

  factory AiMatchResponseModel.fromJson(Map<String, dynamic> json) =>
      AiMatchResponseModel(
        userId: json['user_id'] as int,
        matchScore: (json['match_score'] as num).toDouble(),
        matchReason: json['match_reason'] as String,
      );

  AiMatch toEntity() => AiMatch(
        userId: userId,
        matchScore: matchScore,
        matchReason: matchReason,
      );
}
