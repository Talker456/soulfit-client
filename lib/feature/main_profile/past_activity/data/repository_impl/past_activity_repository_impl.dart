import '../../domain/repositories/past_activity_repository.dart';
import '../../domain/entities/paginated_meetings.dart';
import '../../domain/entities/ai_summary.dart';
import '../../domain/entities/hosting_record.dart';
import '../datasources/past_activity_remote_datasource.dart';

class PastActivityRepositoryImpl implements PastActivityRepository {
  final PastActivityRemoteDataSource remoteDataSource;

  PastActivityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PaginatedMeetings> getParticipatedMeetings({
    required int page,
    required int size,
  }) async {
    return await remoteDataSource.getParticipatedMeetings(
      page: page,
      size: size,
    );
  }

  @override
  Future<PaginatedMeetings> getApplicationMeetings({
    required int page,
    required int size,
  }) async {
    return await remoteDataSource.getApplicationMeetings(
      page: page,
      size: size,
    );
  }

  @override
  Future<List<HostingRecord>> getHostedMeetings({
    required int page,
    required int size,
  }) async {
    return await remoteDataSource.getHostedMeetings(
      page: page,
      size: size,
    );
  }

  @override
  Future<AiSummary> getAiSummary() async {
    return await remoteDataSource.getAiSummary();
  }
}
