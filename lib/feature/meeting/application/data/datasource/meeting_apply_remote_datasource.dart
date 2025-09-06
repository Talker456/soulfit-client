import '../../domain/entity/meeting_application.dart';

abstract class MeetingApplyRemoteDataSource {
  Future<void> submit(MeetingApplication application);
}
