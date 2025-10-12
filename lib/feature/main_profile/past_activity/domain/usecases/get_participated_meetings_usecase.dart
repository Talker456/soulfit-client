import '../repositories/past_activity_repository.dart';
import '../entities/paginated_meetings.dart';

// 과거 참여 내역 조회 UseCase
class GetParticipatedMeetingsUseCase {
  final PastActivityRepository repository;

  GetParticipatedMeetingsUseCase({required this.repository});

  Future<PaginatedMeetings> call({
    required int page,
    required int size,
  }) async {
    return await repository.getParticipatedMeetings(page: page, size: size);
  }
}
