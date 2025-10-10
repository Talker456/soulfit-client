import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/entity/meeting_dashboard_stats.dart';

class QuickStatsGrid extends StatelessWidget {
  final MeetingDashboardStats stats;

  const QuickStatsGrid({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5, // Adjust aspect ratio for better layout
      children: [
        _StatCard(title: '최다 참여 카테고리', value: stats.mostAttendedCategory),
        _StatCard(title: '최다 참여 요일', value: stats.favoriteDayOfWeek),
        _StatCard(title: '최다 참여 시간대', value: stats.favoriteTimeOfDay),
        _StatCard(title: '주요 활동 지역', value: stats.mostFrequentRegion),
        _StatCard(title: '평균 모임 규모', value: '${stats.averageMeetingSize.toStringAsFixed(1)}명'),
        _StatCard(title: '내가 준 평점 평균', value: stats.averageRatingGiven.toStringAsFixed(1)),
        _StatCard(title: '내가 받은 평점 평균', value: stats.averageRatingReceivedAsHost.toStringAsFixed(1)),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;

  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
            const SizedBox(height: 8),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(value, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
