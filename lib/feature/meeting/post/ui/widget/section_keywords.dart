// widget/section_keywords.dart
import 'package:flutter/material.dart';

class SectionKeywords extends StatelessWidget {
  final List<String> keywords;
  const SectionKeywords({super.key, required this.keywords});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: -8,
      children: keywords.map((k) => Chip(label: Text(k))).toList(),
    );
  }
}
