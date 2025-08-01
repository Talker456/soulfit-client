import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';

class GetRecentlyCreatedMeetingsUseCase {
  final MeetingRepository repository;

  GetRecentlyCreatedMeetingsUseCase(this.repository);

  Future<List<MeetingSummary>> execute({required int page, required int size}) {
    return repository.getRecentlyCreatedMeetings(page: page, size: size);
  }
}
