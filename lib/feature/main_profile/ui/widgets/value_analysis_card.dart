
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/main_profile/domain/entity/user_profile_screen_data.dart';

class ValueAnalysisCard extends StatelessWidget {
  final UserProfileScreenData data;

  const ValueAnalysisCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("○○님의 가치관",
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text("AI가 분석한 ○○님은..."),
            Text(data.valueAnalysis.summary,
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text("분석 미리보기",
                style: TextStyle(fontSize: 12, color: Colors.black54)),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                    child: _buildChartStub(
                        "○○성향 분석", data.valueAnalysis.chartA)),
                const SizedBox(width: 8),
                Expanded(
                    child: _buildChartStub(
                        "○○성향 분석", data.valueAnalysis.chartB)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("상세 분석 보러가기",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 4),
                Icon(Icons.lock, size: 16, color: Colors.amber),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildChartStub(String title, List chart) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11)),
        const SizedBox(height: 4),
        ...chart.map<Widget>((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: [
                SizedBox(
                    width: 60,
                    child: Text(c.label, style: const TextStyle(fontSize: 12))),
                const SizedBox(width: 4),
                Expanded(
                  child: LinearProgressIndicator(
                    value: c.score,
                    minHeight: 8,
                    backgroundColor: Colors.grey[200],
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
