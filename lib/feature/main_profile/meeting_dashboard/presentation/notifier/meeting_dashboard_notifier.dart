import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/usecase/get_meeting_dashboard_stats_usecase.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/usecase/get_participated_meetings_usecase.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/state/meeting_dashboard_state.dart';

import '../../domain/entity/meeting_dashboard_stats.dart';
import '../../domain/entity/paginated_meetings.dart';

class MeetingDashboardNotifier extends StateNotifier<MeetingDashboardState> {
  final GetMeetingDashboardStatsUseCase _getStatsUseCase;
  final GetParticipatedMeetingsUseCase _getMeetingsUseCase;

  MeetingDashboardNotifier({
    required GetMeetingDashboardStatsUseCase getStatsUseCase,
    required GetParticipatedMeetingsUseCase getMeetingsUseCase,
  })  : _getStatsUseCase = getStatsUseCase,
        _getMeetingsUseCase = getMeetingsUseCase,
        super(MeetingDashboardInitial()) {
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    state = MeetingDashboardLoading();
    try {
      // Fetch stats and recent meetings in parallel
      final results = await Future.wait([
        _getStatsUseCase(),
        _getMeetingsUseCase(page: 0, size: 10), // Initial page
      ]);

      final stats = results[0] as MeetingDashboardStats;
      final meetings = results[1] as PaginatedMeetings;

      state = MeetingDashboardLoaded(
        stats: stats,
        participatedMeetings: meetings,
        hasMore: !meetings.last,
      );
    } catch (e) {
      state = MeetingDashboardError('Failed to load dashboard data: $e');
    }
  }

  Future<void> loadMoreParticipatedMeetings() async {
    if (state is! MeetingDashboardLoaded) return;

    final currentState = state as MeetingDashboardLoaded;
    if (currentState.isLoadingMore || !currentState.hasMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    try {
      final nextPage = currentState.participatedMeetings.number + 1;
      final newMeetings = await _getMeetingsUseCase(page: nextPage, size: 10);

      final updatedContent = [...currentState.participatedMeetings.content, ...newMeetings.content];
      
      final updatedPaginatedMeetings = PaginatedMeetings(
        content: updatedContent,
        totalPages: newMeetings.totalPages,
        totalElements: newMeetings.totalElements,
        last: newMeetings.last,
        number: newMeetings.number,
      );

      state = currentState.copyWith(
        participatedMeetings: updatedPaginatedMeetings,
        hasMore: !newMeetings.last,
        isLoadingMore: false,
      );
    } catch (e) {
      // In case of error, revert the loading state
      state = currentState.copyWith(isLoadingMore: false);
      // Optionally, handle the error in the UI
    }
  }
}
