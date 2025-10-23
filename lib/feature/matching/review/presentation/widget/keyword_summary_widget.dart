
import 'package:flutter/material.dart';

class KeywordSummaryWidget extends StatelessWidget {
  final List<String> keywords;

  const KeywordSummaryWidget({super.key, required this.keywords});

  @override
  Widget build(BuildContext context) {
    if (keywords.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: keywords
            .map((keyword) => Chip(
                  label: Text(keyword),
                  backgroundColor: Colors.grey.shade200,
                ))
            .toList(),
      ),
    );
  }
}
