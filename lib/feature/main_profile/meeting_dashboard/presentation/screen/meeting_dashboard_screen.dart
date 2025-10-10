import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/provider/meeting_dashboard_provider.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/state/meeting_dashboard_state.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/widget/category_distribution_pie_chart.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/widget/monthly_activity_chart.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/widget/participated_meeting_list_view.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/widget/quick_stats_grid.dart';

class MeetingDashboardScreen extends ConsumerWidget {
  const MeetingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(meetingDashboardNotifierProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 대시보드'),
        centerTitle: true,
      ),
      body: switch (state) {
        MeetingDashboardInitial() ||
        MeetingDashboardLoading() =>
          const Center(child: CircularProgressIndicator()),
        MeetingDashboardError(:final message) => Center(
            child: Text(message),
          ),
        MeetingDashboardLoaded(:final stats, :final participatedMeetings) =>
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text('종합 통계', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              QuickStatsGrid(stats: stats),
              const SizedBox(height: 24),
              Text('월별 활동', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              MonthlyActivityChart(monthlyActivity: stats.monthlyActivity),
              const SizedBox(height: 24),
              CategoryDistributionPieChart(categoryDistribution: stats.categoryDistribution),
              const SizedBox(height: 24),
              Text('최근 참여 모임', style: theme.textTheme.headlineSmall),
              const SizedBox(height: 16),
              ParticipatedMeetingListView(paginatedMeetings: participatedMeetings),
            ],
          ),
      },
    );
  }
}
