import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String job;
  final String heightBody;
  final String religion;
  final String smokingDrinking;

  const ProfileInfoSection({
    super.key,
    required this.job,
    required this.heightBody,
    required this.religion,
    required this.smokingDrinking,
  });

  @override
  Widget build(BuildContext context) {
    Widget row(String k, String v) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(k, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(v)),
        ],
      ),
    );

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('기본 정보', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            row('직업/직장', job),
            row('키/체형', heightBody),
            row('종교', religion),
            row('흡연/음주', smokingDrinking),
          ],
        ),
      ),
    );
  }
}
