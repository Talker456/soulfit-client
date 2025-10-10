import '../entity/meeting_dashboard_stats.dart';
import '../repository/meeting_dashboard_repository.dart';

class GetMeetingDashboardStatsUseCase {
  final MeetingDashboardRepository repository;

  GetMeetingDashboardStatsUseCase(this.repository);

  Future<MeetingDashboardStats> call() {
    return repository.getMeetingDashboardStats();
  }
}
