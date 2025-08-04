import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';
import '../entity/meeting_filter_params.dart';

class GetUserRecentJoinedMeetingsUseCase {
  final MeetingRepository repository;

  GetUserRecentJoinedMeetingsUseCase(this.repository);

  Future<List<MeetingSummary>> execute({required int page, required int size, MeetingFilterParams? filterParams}) {
    return repository.getUserRecentJoinedMeetings(page: page, size: size, filterParams: filterParams);
  }
}
