import '../../domain/entity/meeting_application.dart';
import '../../domain/repository/meeting_application_repository.dart';
import '../datasource/meeting_apply_remote_datasource.dart';

class MeetingApplicationRepositoryImpl implements MeetingApplicationRepository {
  final MeetingApplyRemoteDataSource remote;
  MeetingApplicationRepositoryImpl({required this.remote});

  @override
  Future<bool> submit(MeetingApplication application) async {
    await remote.submit(application);
    return true;
  }
}
