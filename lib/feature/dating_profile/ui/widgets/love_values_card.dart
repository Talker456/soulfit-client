import 'package:flutter/material.dart';
import './profile_card.dart';

class LoveValuesCard extends StatelessWidget {
  final String text;
  final String nickname;

  const LoveValuesCard({super.key, required this.text, required this.nickname});

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$nickname님의 연애가치관', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Divider(color: Colors.pink.shade100),
            const SizedBox(height: 8),
            Text(
              'AI가 분석한 $nickname님은...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
