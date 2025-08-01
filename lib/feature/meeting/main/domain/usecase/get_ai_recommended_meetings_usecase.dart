import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';

class AiRecommendationResult {
  final List<MeetingSummary> meetings;
  final List<String> tags;

  AiRecommendationResult({required this.meetings, required this.tags});
}

class GetAiRecommendedMeetingsUseCase {
  final MeetingRepository repository;

  GetAiRecommendedMeetingsUseCase(this.repository);

  Future<AiRecommendationResult> execute({required int page, required int size}) async {
    final result = await repository.getAiRecommendedMeetings(page: page, size: size);
    return AiRecommendationResult(
      meetings: result['meetings'] as List<MeetingSummary>,
      tags: result['tags'] as List<String>,
    );
  }
}
