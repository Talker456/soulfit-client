import '../../domain/entity/user_value_analysis.dart';
import 'value_chart_dto.dart';

class UserValueAnalysisDto {
  final String summary;
  final List<ValueChartDto> chartA;
  final List<ValueChartDto> chartB;

  UserValueAnalysisDto({
    required this.summary,
    required this.chartA,
    required this.chartB,
  });

  factory UserValueAnalysisDto.fromJson(Map<String, dynamic> json) {
    return UserValueAnalysisDto(
      summary: json['summary'],
      chartA: (json['chartA'] as List).map((e) => ValueChartDto.fromJson(e)).toList(),
      chartB: (json['chartB'] as List).map((e) => ValueChartDto.fromJson(e)).toList(),
    );
  }

  UserValueAnalysis toEntity() {
    return UserValueAnalysis(
      summary: summary,
      chartA: chartA.map((e) => e.toEntity()).toList(),
      chartB: chartB.map((e) => e.toEntity()).toList(),
    );
  }
}
