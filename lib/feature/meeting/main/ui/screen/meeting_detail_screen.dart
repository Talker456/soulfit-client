import 'package:flutter/material.dart';

class MeetingDetailScreen extends StatelessWidget {
  final String meetingId;

  const MeetingDetailScreen({super.key, required this.meetingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 상세 정보'),
      ),
      body: Center(
        child: Text('Meeting ID: $meetingId\n\n(상세 페이지 UI 구현 예정)'),
      ),
    );
  }
}
