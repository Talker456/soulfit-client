import 'package:equatable/equatable.dart';

class ChatAnalysis extends Equatable {
  final double positiveScore; // 긍정 점수 (0.0 ~ 1.0)
  final double negativeScore; // 부정 점수 (0.0 ~ 1.0)
  final String mood;          // 현재 분위기 (예: "UPBEAT", "CALM", "TENSE")
  final List<String> keywords;  // 주요 키워드 리스트

  const ChatAnalysis({
    required this.positiveScore,
    required this.negativeScore,
    required this.mood,
    required this.keywords,
  });

  @override
  List<Object?> get props => [positiveScore, negativeScore, mood, keywords];
}
