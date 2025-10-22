import 'package:equatable/equatable.dart';

class RecommendedReplies extends Equatable {
  final List<Recommendation> recommendations;

  const RecommendedReplies({required this.recommendations});

  @override
  List<Object?> get props => [recommendations];
}

class Recommendation extends Equatable {
  final String text;
  final int score;

  const Recommendation({
    required this.text,
    required this.score,
  });

  @override
  List<Object?> get props => [text, score];
}
