import '../../domain/entities/meeting_post_detail.dart';
import '../../domain/repositories/meeting_post_repository.dart';
import '../datasources/meeting_post_remote_datasource.dart';

/// Meeting Post Repository 구현
/// Domain과 Data Layer를 연결하는 Repository 구현체
class MeetingPostRepositoryImpl implements MeetingPostRepository {
  final MeetingPostRemoteDataSource remoteDataSource;

  MeetingPostRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<MeetingPostDetail> getMeetingPostDetail(String meetingId) async {
    try {
      final model = await remoteDataSource.getMeetingPostDetail(meetingId);
      return model.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
