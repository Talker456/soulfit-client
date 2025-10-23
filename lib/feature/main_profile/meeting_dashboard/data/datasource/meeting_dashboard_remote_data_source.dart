import '../model/meeting_dashboard_stats_model.dart';
import '../model/paginated_meetings_model.dart';

abstract class MeetingDashboardRemoteDataSource {
  Future<MeetingDashboardStatsModel> getMeetingDashboardStats();
  Future<PaginatedMeetingsModel> getParticipatedMeetings({required int page, required int size});
}
