// widget/section_supplies.dart
import 'package:flutter/material.dart';

class SectionSupplies extends StatelessWidget {
  final List<String> items;
  const SectionSupplies({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: -8,
      children: items.map((e) => Chip(label: Text(e))).toList(),
    );
  }
}
