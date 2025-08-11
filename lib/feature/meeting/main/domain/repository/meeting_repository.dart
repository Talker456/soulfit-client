import '../entity/meeting_summary.dart';
import '../entity/meeting_filter_params.dart';

abstract class MeetingRepository {
  Future<Map<String, dynamic>> getAiRecommendedMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<List<MeetingSummary>> getPopularMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<List<MeetingSummary>> getRecentlyCreatedMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<List<MeetingSummary>> getUserRecentJoinedMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<List<MeetingSummary>> getMeetingsByCategory({required String category, required int page, required int size, MeetingFilterParams? filterParams});
}
