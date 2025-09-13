import 'package:flutter/material.dart';

class ProfileTagWrap extends StatelessWidget {
  final List<String> tags;
  const ProfileTagWrap({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: -6,
      children:
          tags
              .map(
                (t) => Chip(
                  label: Text(t),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              )
              .toList(),
    );
  }
}
