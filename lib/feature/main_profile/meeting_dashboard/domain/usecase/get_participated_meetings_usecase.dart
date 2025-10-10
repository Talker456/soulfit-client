import '../entity/paginated_meetings.dart';
import '../repository/meeting_dashboard_repository.dart';

class GetParticipatedMeetingsUseCase {
  final MeetingDashboardRepository repository;

  GetParticipatedMeetingsUseCase(this.repository);

  Future<PaginatedMeetings> call({required int page, required int size}) {
    return repository.getParticipatedMeetings(page: page, size: size);
  }
}
