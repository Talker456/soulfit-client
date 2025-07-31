import 'dart:async';
import '../model/meeting_summary_model.dart';
import 'meeting_remote_data_source.dart';

class FakeMeetingRemoteDataSourceImpl implements MeetingRemoteDataSource {
  static const _dummy = MeetingSummaryModel(
    meetingId: 'm001',
    title: '와인 모임',
    thumbnailUrl: 'https://picsum.photos/400/400',
    category: '파티',
    currentParticipants: 5,
    maxParticipants: 10,
  );

  Future<List<MeetingSummaryModel>> _generateDummyList(String type, {required int page, required int size}) async {
    print('[DataSource] Received request for $type - Page: $page, Size: $size');
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency

    // 예시로 총 100개의 가상 데이터를 생성한다고 가정
    final totalItems = List.generate(
      100,
          (index) => MeetingSummaryModel(
        meetingId: '$type-${index + 1}',
        title: '[서울] $type 모임 ${index + 1}',
        thumbnailUrl: 'https://picsum.photos/400/400?random=$type$index',
        category: type,
        currentParticipants: (index % 10) + 1,
        maxParticipants: 10,
      ),
    );

    // 페이지에 해당하는 부분을 잘라서 반환
    final startIndex = (page - 1) * size;
    if (startIndex >= totalItems.length) {
      print('[DataSource] No more items to return for page $page. Returning 0 items.');
      return []; // 요청한 페이지에 데이터가 없으면 빈 리스트 반환
    }
    final result = totalItems.skip(startIndex).take(size).toList();
    print('[DataSource] Returning ${result.length} items for page $page.');
    return result;
  }

  @override
  Future<List<MeetingSummaryModel>> getAiRecommendedMeetings({required int page, required int size}) => _generateDummyList("추천", page: page, size: size);

  @override
  Future<List<MeetingSummaryModel>> getPopularMeetings({required int page, required int size}) => _generateDummyList("인기", page: page, size: size);

  @override
  Future<List<MeetingSummaryModel>> getRecentlyCreatedMeetings({required int page, required int size}) => _generateDummyList("신규", page: page, size: size);

  @override
  Future<List<MeetingSummaryModel>> getUserRecentJoinedMeetings({required int page, required int size}) => _generateDummyList("참여", page: page, size: size);
}
