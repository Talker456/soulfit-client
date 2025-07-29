class ValueChart {
  final String label;
  final double score;

  ValueChart({
    required this.label,
    required this.score,
  });
}

class UserValueAnalysis {
  final String summary;
  final List<ValueChart> chartA;
  final List<ValueChart> chartB;

  UserValueAnalysis({
    required this.summary,
    required this.chartA,
    required this.chartB,
  });
}
