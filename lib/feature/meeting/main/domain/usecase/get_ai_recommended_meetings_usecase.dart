import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';

class GetAiRecommendedMeetingsUseCase {
  final MeetingRepository repository;

  GetAiRecommendedMeetingsUseCase(this.repository);

  Future<List<MeetingSummary>> execute({required int page, required int size}) {
    return repository.getAiRecommendedMeetings(page: page, size: size);
  }
}
