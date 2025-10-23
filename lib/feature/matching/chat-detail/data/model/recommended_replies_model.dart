import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/recommended_replies.dart';

class RecommendedRepliesModel extends RecommendedReplies {
  const RecommendedRepliesModel({required super.recommendations});

  factory RecommendedRepliesModel.fromJson(Map<String, dynamic> json) {
    return RecommendedRepliesModel(
      recommendations: (json['recommendations'] as List)
          .map((e) => RecommendationModel.fromJson(e))
          .toList(),
    );
  }

  RecommendedReplies toEntity() {
    return RecommendedReplies(
      recommendations: recommendations
          .map((e) => (e as RecommendationModel).toEntity())
          .toList(),
    );
  }
}

class RecommendationModel extends Recommendation {
  const RecommendationModel({required super.text, required super.score});

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      text: json['text'],
      score: json['score'],
    );
  }

  Recommendation toEntity() {
    return Recommendation(
      text: text,
      score: score,
    );
  }
}
