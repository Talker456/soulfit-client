// widget/section_participant_stats.dart
import 'package:flutter/material.dart';
import '../state/meeting_post_state.dart';

class SectionParticipantStats extends StatelessWidget {
  final MPStats stats;
  const SectionParticipantStats({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    Widget bar(double v) => LinearProgressIndicator(value: v, minHeight: 10);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('성별 분포'),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(child: bar(stats.malePercent / 100)),
            const SizedBox(width: 8),
            Text('${stats.malePercent}% ${stats.femalePercent}%'),
          ],
        ),
        const SizedBox(height: 16),
        const Text('연령별 분포'),
        const SizedBox(height: 8),
        ...stats.age.entries.map((e) {
          final male = e.value.$1.toDouble();
          final female = e.value.$2.toDouble();
          final total = (male + female) == 0 ? 1 : (male + female);
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                SizedBox(width: 44, child: Text(e.key)),
                Expanded(child: bar(male / total)),
                const SizedBox(width: 6),
                Expanded(child: bar(female / total)),
              ],
            ),
          );
        }),
      ],
    );
  }
}
