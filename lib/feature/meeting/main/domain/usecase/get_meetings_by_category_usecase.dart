import '../entity/meeting_summary.dart';
import '../repository/meeting_repository.dart';
import '../entity/meeting_filter_params.dart';

class GetMeetingsByCategoryUseCase {
  final MeetingRepository repository;

  GetMeetingsByCategoryUseCase(this.repository);

  Future<List<MeetingSummary>> execute({
    required String category,
    required int page,
    required int size,
    MeetingFilterParams? filterParams,
  }) {
    return repository.getMeetingsByCategory(
      category: category,
      page: page,
      size: size,
      filterParams: filterParams,
    );
  }
}
