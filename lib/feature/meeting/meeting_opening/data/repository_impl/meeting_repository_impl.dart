import '../../domain/entities/meeting.dart';
import '../../domain/repositories/meeting_repository.dart';
import '../datasources/meeting_remote_datasource.dart';
import '../models/meeting_model.dart';

/// Meeting Repository 구현
/// Domain과 Data Layer를 연결하는 Repository 구현체
class MeetingRepositoryImpl implements MeetingRepository {
  final MeetingRemoteDataSource remoteDataSource;

  MeetingRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<int> createMeeting(Meeting meeting) async {
    try {
      final meetingModel = MeetingModel.fromEntity(meeting);
      final meetingId = await remoteDataSource.createMeeting(meetingModel);
      return meetingId;
    } catch (e) {
      rethrow;
    }
  }
}
