import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double value;
  const ProgressBar({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: LinearProgressIndicator(
          value: value, // (current + 1) / total
          backgroundColor: Colors.grey.shade300, // 요청하신 회색 배경
          color: const Color(0xFF22C55E), // 초록색
          minHeight: 6,
        ),
      ),
    );
  }
}
