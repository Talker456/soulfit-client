import 'package:flutter/material.dart';

class LoveValuesCard extends StatelessWidget {
  final String text;
  const LoveValuesCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('OO님의 연애가치관', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              'AI가 분석한 OO님은...',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
