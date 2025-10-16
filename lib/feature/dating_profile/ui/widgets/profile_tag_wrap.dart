import 'package:flutter/material.dart';

class ProfileTagWrap extends StatelessWidget {
  final List<String> tags;
  const ProfileTagWrap({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children:
          tags
              .map(
                (t) => Chip(
                  label: Text(t, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                  backgroundColor: const Color(0xFFFFF0F5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFFFFC1D5), width: 2),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                ),
              )
              .toList(),
    );
  }
}
