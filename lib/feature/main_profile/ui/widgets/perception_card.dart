
import 'package:flutter/material.dart';

class PerceptionCard extends StatelessWidget {
  final String title;
  final List<String> keywords;

  const PerceptionCard({
    super.key,
    required this.title,
    required this.keywords,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              children:
                  keywords.map<Widget>((k) => Chip(label: Text(k))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
