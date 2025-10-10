import '../entity/meeting_dashboard_stats.dart';
import '../entity/paginated_meetings.dart';

abstract class MeetingDashboardRepository {
  Future<MeetingDashboardStats> getMeetingDashboardStats();
  Future<PaginatedMeetings> getParticipatedMeetings({int page, int size});
}
