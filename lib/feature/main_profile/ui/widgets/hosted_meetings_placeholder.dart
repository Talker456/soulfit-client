
import 'package:flutter/material.dart';

class HostedMeetingsPlaceholder extends StatelessWidget {
  const HostedMeetingsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(
        child: Text("○○님이 주최한 모임 보기 >",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
