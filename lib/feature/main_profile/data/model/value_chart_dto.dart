import '../../domain/entity/user_value_analysis.dart';

class ValueChartDto {
  final String label;
  final double score;

  ValueChartDto({required this.label, required this.score});

  factory ValueChartDto.fromJson(Map<String, dynamic> json) {
    return ValueChartDto(
      label: json['label'],
      score: (json['score'] as num).toDouble(),
    );
  }

  ValueChart toEntity() {
    return ValueChart(label: label, score: score);
  }
}
