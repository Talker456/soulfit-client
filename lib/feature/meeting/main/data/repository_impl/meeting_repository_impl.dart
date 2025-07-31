import '../../domain/entity/meeting_summary.dart';
import '../../domain/repository/meeting_repository.dart';
import '../datasource/meeting_remote_data_source.dart';

class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingRemoteDataSource remoteDataSource;

  MeetingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MeetingSummary>> getAiRecommendedMeetings({required int page, required int size}) async {
    final models = await remoteDataSource.getAiRecommendedMeetings(page: page, size: size);
    return models;
  }

  @override
  Future<List<MeetingSummary>> getPopularMeetings({required int page, required int size}) async {
    print('[Repository] Forwarding request for PopularMeetings - Page: $page, Size: $size');
    final models = await remoteDataSource.getPopularMeetings(page: page, size: size);
    return models;
  }

  @override
  Future<List<MeetingSummary>> getRecentlyCreatedMeetings({required int page, required int size}) async {
    final models = await remoteDataSource.getRecentlyCreatedMeetings(page: page, size: size);
    return models;
  }

  @override
  Future<List<MeetingSummary>> getUserRecentJoinedMeetings({required int page, required int size}) async {
    final models = await remoteDataSource.getUserRecentJoinedMeetings(page: page, size: size);
    return models;
  }
}
