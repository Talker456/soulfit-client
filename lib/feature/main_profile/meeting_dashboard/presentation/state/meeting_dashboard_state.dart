import 'package:flutter/foundation.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/entity/meeting_dashboard_stats.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/entity/paginated_meetings.dart';

@immutable
sealed class MeetingDashboardState {}

class MeetingDashboardInitial extends MeetingDashboardState {}

class MeetingDashboardLoading extends MeetingDashboardState {}

class MeetingDashboardLoaded extends MeetingDashboardState {
  final MeetingDashboardStats stats;
  final PaginatedMeetings participatedMeetings;
  final bool hasMore;
  final bool isLoadingMore;

  MeetingDashboardLoaded({
    required this.stats,
    required this.participatedMeetings,
    this.hasMore = true,
    this.isLoadingMore = false,
  });

  MeetingDashboardLoaded copyWith({
    MeetingDashboardStats? stats,
    PaginatedMeetings? participatedMeetings,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return MeetingDashboardLoaded(
      stats: stats ?? this.stats,
      participatedMeetings: participatedMeetings ?? this.participatedMeetings,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class MeetingDashboardError extends MeetingDashboardState {
  final String message;

  MeetingDashboardError(this.message);
}
