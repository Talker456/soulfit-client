import 'package:flutter/material.dart';

class EventBanner extends StatelessWidget {
  const EventBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.green),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: const Text(
          '진행중인 이벤트 광고\n(앱 운영자가 관리)',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
