import '../entity/meeting_application.dart';

abstract class MeetingApplicationRepository {
  Future<bool> submit(MeetingApplication application);
}
