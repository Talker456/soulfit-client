import '../repositories/past_activity_repository.dart';
import '../entities/hosting_record.dart';

// 과거 개설 내역 조회 UseCase
class GetHostedMeetingsUseCase {
  final PastActivityRepository repository;

  GetHostedMeetingsUseCase({required this.repository});

  Future<List<HostingRecord>> call({
    required int page,
    required int size,
  }) async {
    return await repository.getHostedMeetings(page: page, size: size);
  }
}
