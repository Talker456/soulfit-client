import 'package:flutter/material.dart';
import './profile_card.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 80,
                child: Text(k, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(child: Text(v, style: Theme.of(context).textTheme.bodyLarge)),
            ],
          ),
        );

    return ProfileCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('기본 정보', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Divider(color: Colors.pink.shade100),
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
