// widget/section_places.dart
import 'package:flutter/material.dart';

class SectionPlaces extends StatelessWidget {
  final String fullAddress;
  const SectionPlaces({
    super.key,
    required this.fullAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('모임 장소', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          height: 160,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF22C55E)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text('지도(추후 SDK 연동)')),
        ),
        const SizedBox(height: 6),
        Text(fullAddress),
        const SizedBox(height: 16),
      ],
    );
  }
}
