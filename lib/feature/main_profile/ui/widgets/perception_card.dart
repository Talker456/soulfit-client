
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            children: keywords
                .map<Widget>((e) => Chip(label: Text(e), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), backgroundColor: Colors.green[50]))
                .toList(),
          ),
        ],
      ),
    );
  }
}
