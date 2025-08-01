import 'dart:async';
import 'dart:math';
import '../model/meeting_summary_model.dart';
import 'meeting_remote_data_source.dart';

class FakeMeetingRemoteDataSourceImpl implements MeetingRemoteDataSource {
  final Random _random = Random();

  Future<Map<String, dynamic>> _generateDummyData(String type, {required int page, required int size}) async {
    print('[DataSource] Received request for $type - Page: $page, Size: $size');
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency

    final totalItems = List.generate(
      100,
      (index) => MeetingSummaryModel(
        meetingId: '$type-${index + 1}',
        title: '[서울] $type 모임 ${index + 1}',
        thumbnailUrl: 'https://picsum.photos/400/400?random=$type$index',
        category: type,
        currentParticipants: (index % 10) + 1,
        maxParticipants: 10,
        price: (index % 5) * 10000 + 10000, // 10,000 ~ 50,000
      ),
    );

    final startIndex = (page - 1) * size;
    if (startIndex >= totalItems.length) {
      print('[DataSource] No more items to return for page $page. Returning 0 items.');
      return {'meetings': <MeetingSummaryModel>[], 'tags': <String>[]};
    }

    final result = totalItems.skip(startIndex).take(size).toList();
    print('[DataSource] Returning ${result.length} items for page $page.');

    // AI 추천 모임일 경우에만 태그 반환
    final tags = (type == "추천") ? ["활동적", "수공예", "음악"] : <String>[];

    return {'meetings': result, 'tags': tags};
  }

  @override
  Future<Map<String, dynamic>> getAiRecommendedMeetings({required int page, required int size}) =>
      _generateDummyData("추천", page: page, size: size);

  @override
  Future<Map<String, dynamic>> getPopularMeetings({required int page, required int size}) =>
      _generateDummyData("인기", page: page, size: size);

  @override
  Future<Map<String, dynamic>> getRecentlyCreatedMeetings({required int page, required int size}) =>
      _generateDummyData("신규", page: page, size: size);

  @override
  Future<Map<String, dynamic>> getUserRecentJoinedMeetings({required int page, required int size}) =>
      _generateDummyData("참여", page: page, size: size);
}
