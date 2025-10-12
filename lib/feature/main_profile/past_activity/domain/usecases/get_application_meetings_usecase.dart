import '../repositories/past_activity_repository.dart';
import '../entities/paginated_meetings.dart';

// 모임 신청 내역 조회 UseCase
class GetApplicationMeetingsUseCase {
  final PastActivityRepository repository;

  GetApplicationMeetingsUseCase({required this.repository});

  Future<PaginatedMeetings> call({
    required int page,
    required int size,
  }) async {
    return await repository.getApplicationMeetings(page: page, size: size);
  }
}
