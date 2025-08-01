import '../model/meeting_summary_model.dart';

abstract class MeetingRemoteDataSource {
  Future<Map<String, dynamic>> getAiRecommendedMeetings({required int page, required int size});
  Future<Map<String, dynamic>> getPopularMeetings({required int page, required int size});
  Future<Map<String, dynamic>> getRecentlyCreatedMeetings({required int page, required int size});
  Future<Map<String, dynamic>> getUserRecentJoinedMeetings({required int page, required int size});
}
