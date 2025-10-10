import 'package:soulfit_client/feature/main_profile/meeting_dashboard/data/datasource/meeting_dashboard_remote_data_source.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/entity/meeting_dashboard_stats.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/entity/paginated_meetings.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/repository/meeting_dashboard_repository.dart';

class MeetingDashboardRepositoryImpl implements MeetingDashboardRepository {
  final MeetingDashboardRemoteDataSource remoteDataSource;

  MeetingDashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<MeetingDashboardStats> getMeetingDashboardStats() async {
    // The remote data source returns a model that extends the entity,
    // so it can be returned directly.
    return await remoteDataSource.getMeetingDashboardStats();
  }

  @override
  Future<PaginatedMeetings> getParticipatedMeetings({int page = 0, int size = 10}) async {
    // The remote data source returns a model that extends the entity,
    // so it can be returned directly.
    return await remoteDataSource.getParticipatedMeetings(page: page, size: size);
  }
}
