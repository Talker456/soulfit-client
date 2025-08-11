import '../model/meeting_summary_model.dart';
import '../../domain/entity/meeting_filter_params.dart';

abstract class MeetingRemoteDataSource {
  Future<Map<String, dynamic>> getAiRecommendedMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<Map<String, dynamic>> getPopularMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<Map<String, dynamic>> getRecentlyCreatedMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<Map<String, dynamic>> getUserRecentJoinedMeetings({required int page, required int size, MeetingFilterParams? filterParams});
  Future<Map<String, dynamic>> getMeetingsByCategory({required String category, required int page, required int size, MeetingFilterParams? filterParams});
}
