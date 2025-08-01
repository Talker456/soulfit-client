import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';

class GetPopularMeetingsUseCase {
  final MeetingRepository repository;

  GetPopularMeetingsUseCase(this.repository);

  Future<List<MeetingSummary>> execute({required int page, required int size}) {
    return repository.getPopularMeetings(page: page, size: size);
  }
}
