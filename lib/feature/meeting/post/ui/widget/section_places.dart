// widget/section_places.dart
import 'package:flutter/material.dart';

class SectionPlaces extends StatelessWidget {
  final String meetAddress;
  final String venueAddress;
  const SectionPlaces({
    super.key,
    required this.meetAddress,
    required this.venueAddress,
  });

  Widget _map(BuildContext c, String caption, String addr) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(caption, style: Theme.of(c).textTheme.titleMedium),
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
        Text(addr),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _map(context, '모이는 장소', meetAddress),
        _map(context, '진행 장소', venueAddress),
      ],
    );
  }
}
