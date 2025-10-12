import '../../domain/entities/ai_summary.dart';

// AI Summary Model
class AiSummaryModel extends AiSummary {
  AiSummaryModel({
    required super.totalParticipation,
    required super.mainActivities,
    required super.nextRecommendations,
  });

  factory AiSummaryModel.fromJson(Map<String, dynamic> json) {
    return AiSummaryModel(
      totalParticipation: json['totalParticipation'] as int? ?? 0,
      mainActivities: (json['mainActivities'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      nextRecommendations: (json['nextRecommendations'] as List?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'totalParticipation': totalParticipation,
        'mainActivities': mainActivities,
        'nextRecommendations': nextRecommendations,
      };
}
