// widget/section_participant_stats.dart
import 'package:flutter/material.dart';
import '../state/meeting_post_state.dart';

class SectionParticipantStats extends StatelessWidget {
  final MPStats stats;
  const SectionParticipantStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    Widget bar(double v) => LinearProgressIndicator(
        value: v, minHeight: 10, borderRadius: BorderRadius.circular(5));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('성별 분포', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            Text('남성', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 8),
            Expanded(child: bar(stats.malePercent / 100)),
            const SizedBox(width: 8),
            Text('${stats.malePercent.toStringAsFixed(1)}%'),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text('여성', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 8),
            Expanded(child: bar(stats.femalePercent / 100)),
            const SizedBox(width: 8),
            Text('${stats.femalePercent.toStringAsFixed(1)}%'),
          ],
        ),
        const SizedBox(height: 24),
        Text('연령별 분포', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (stats.ageDistribution.isEmpty)
          const Text('참가자 정보가 없습니다.')
        else
          ...stats.ageDistribution.entries.map((e) {
            final percentage = e.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  SizedBox(width: 44, child: Text(e.key)),
                  Expanded(child: bar(percentage / 100.0)),
                  const SizedBox(width: 8),
                  Text('${percentage.toStringAsFixed(1)}%'),
                ],
              ),
            );
          }),
      ],
    );
  }
}
