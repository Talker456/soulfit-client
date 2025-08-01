import '../model/meeting_summary_model.dart';

abstract class MeetingRemoteDataSource {
  Future<List<MeetingSummaryModel>> getAiRecommendedMeetings({required int page, required int size});
  Future<List<MeetingSummaryModel>> getPopularMeetings({required int page, required int size});
  Future<List<MeetingSummaryModel>> getRecentlyCreatedMeetings({required int page, required int size});
  Future<List<MeetingSummaryModel>> getUserRecentJoinedMeetings({required int page, required int size});
}
