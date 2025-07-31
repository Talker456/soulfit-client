import '../entity/meeting_summary.dart';

abstract class MeetingRepository {
  Future<List<MeetingSummary>> getAiRecommendedMeetings({required int page, required int size});
  Future<List<MeetingSummary>> getPopularMeetings({required int page, required int size});
  Future<List<MeetingSummary>> getRecentlyCreatedMeetings({required int page, required int size});
  Future<List<MeetingSummary>> getUserRecentJoinedMeetings({required int page, required int size});
}
