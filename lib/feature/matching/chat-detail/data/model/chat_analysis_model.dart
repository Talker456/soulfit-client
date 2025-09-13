
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_analysis.dart';

class ChatAnalysisModel extends ChatAnalysis {
  const ChatAnalysisModel({
    required super.positiveScore,
    required super.negativeScore,
    required super.mood,
    required super.keywords,
  });

  factory ChatAnalysisModel.fromJson(Map<String, dynamic> json) {
    return ChatAnalysisModel(
      positiveScore: (json['positiveScore'] as num).toDouble(),
      negativeScore: (json['negativeScore'] as num).toDouble(),
      mood: json['mood'],
      keywords: List<String>.from(json['keywords']),
    );
  }
}
