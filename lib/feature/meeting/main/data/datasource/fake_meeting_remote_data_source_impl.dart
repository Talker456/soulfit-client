import 'dart:async';
import 'dart:math';
import '../model/meeting_summary_model.dart';
import 'meeting_remote_data_source.dart';
import '../../domain/entity/meeting_filter_params.dart';

class FakeMeetingRemoteDataSourceImpl implements MeetingRemoteDataSource {
  final Random _random = Random();

  Future<Map<String, dynamic>> _generateDummyData(String type, {required int page, required int size, MeetingFilterParams? filterParams}) async {
    print('[DataSource] Received request for $type - Page: $page, Size: $size, Filters: $filterParams');
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency

    List<MeetingSummaryModel> allItems = List.generate(
      100,
      (index) => MeetingSummaryModel(
        meetingId: '$type-${index + 1}',
        title: '[서울] $type 모임 ${index + 1}',
        thumbnailUrl: 'https://picsum.photos/400/400?random=$type$index',
        category: type,
        currentParticipants: (index % 10) + 1,
        maxParticipants: 10,
        price: (index % 5) * 10000 + 10000, // 10,000 ~ 50,000
        date: DateTime.now().add(Duration(days: index)), // Assign dummy date
        rating: ((index % 5) + 1).toDouble(), // Assign dummy rating (1.0 to 5.0)
      ),
    );

    // Apply filters
    List<MeetingSummaryModel> filteredItems = allItems.where((meeting) {
      if (filterParams == null) return true;

      if (filterParams.region != null && !meeting.title.contains('[' + filterParams.region! + ']')) {
        return false;
      }
      if (filterParams.minPrice != null && meeting.price < filterParams.minPrice!) {
        return false;
      }
      if (filterParams.maxPrice != null && meeting.price > filterParams.maxPrice!) {
        return false;
      }
      if (filterParams.startDate != null && (meeting.date == null || meeting.date!.isBefore(filterParams.startDate!))) {
        return false;
      }
      if (filterParams.endDate != null && (meeting.date == null || meeting.date!.isAfter(filterParams.endDate!))) {
        return false;
      }
      if (filterParams.minRating != null && (meeting.rating == null || meeting.rating! < filterParams.minRating!)) {
        return false;
      }
      if (filterParams.minParticipants != null && meeting.currentParticipants < filterParams.minParticipants!) {
        return false;
      }
      if (filterParams.maxParticipants != null && meeting.currentParticipants > filterParams.maxParticipants!) {
        return false;
      }

      return true;
    }).toList();

    final startIndex = (page - 1) * size;
    if (startIndex >= filteredItems.length) {
      print('[DataSource] No more items to return for page $page. Returning 0 items.');
      return {'meetings': <MeetingSummaryModel>[], 'tags': <String>[]};
    }

    final result = filteredItems.skip(startIndex).take(size).toList();
    print('[DataSource] Returning ${result.length} items for page $page.');

    // AI 추천 모임일 경우에만 태그 반환
    final tags = (type == "추천") ? ["활동적", "수공예", "음악"] : <String>[];

    return {'meetings': result, 'tags': tags};
  }

  @override
  Future<Map<String, dynamic>> getAiRecommendedMeetings({required int page, required int size, MeetingFilterParams? filterParams}) =>
      _generateDummyData("추천", page: page, size: size, filterParams: filterParams);

  @override
  Future<Map<String, dynamic>> getPopularMeetings({required int page, required int size, MeetingFilterParams? filterParams}) =>
      _generateDummyData("인기", page: page, size: size, filterParams: filterParams);

  @override
  Future<Map<String, dynamic>> getRecentlyCreatedMeetings({required int page, required int size, MeetingFilterParams? filterParams}) =>
      _generateDummyData("신규", page: page, size: size, filterParams: filterParams);

  @override
  Future<Map<String, dynamic>> getUserRecentJoinedMeetings({required int page, required int size, MeetingFilterParams? filterParams}) =>
      _generateDummyData("참여", page: page, size: size, filterParams: filterParams);
}
