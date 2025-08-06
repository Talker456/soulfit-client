import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';
import '../entity/meeting_filter_params.dart';

class GetRecentlyCreatedMeetingsUseCase {
  final MeetingRepository repository;

  GetRecentlyCreatedMeetingsUseCase(this.repository);

  Future<List<MeetingSummary>> execute({required int page, required int size, MeetingFilterParams? filterParams}) {
    return repository.getRecentlyCreatedMeetings(page: page, size: size, filterParams: filterParams);
  }
}
