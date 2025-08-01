import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';

class GetUserRecentJoinedMeetingsUseCase {
  final MeetingRepository repository;

  GetUserRecentJoinedMeetingsUseCase(this.repository);

  Future<List<MeetingSummary>> execute({required int page, required int size}) {
    return repository.getUserRecentJoinedMeetings(page: page, size: size);
  }
}
