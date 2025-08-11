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

    final List<Map<String, String?>> dummyRegions = [
      {'province': '서울', 'district': '강남구'},
      {'province': '서울', 'district': '서초구'},
      {'province': '경기', 'district': '수원시'},
      {'province': '경기', 'district': '성남시'},
      {'province': '부산', 'district': '해운대구'},
      {'province': '부산', 'district': '서면'},
      {'province': '대구', 'district': '동성로'},
      {'province': '인천', 'district': '부평구'},
      {'province': '광주', 'district': '상무지구'},
      {'province': '대전', 'district': '둔산동'},
      {'province': '울산', 'district': '삼산동'},
      {'province': '세종', 'district': null},
      {'province': '강원', 'district': '춘천시'},
      {'province': '충북', 'district': '청주시'},
      {'province': '충남', 'district': '천안시'},
      {'province': '전북', 'district': '전주시'},
      {'province': '전남', 'district': '목포시'},
      {'province': '경북', 'district': '포항시'},
      {'province': '경남', 'district': '창원시'},
      {'province': '제주', 'district': '제주시'},
    ];

    List<MeetingSummaryModel> allItems = List.generate(
      100,
      (index) {
        final selectedRegion = dummyRegions[_random.nextInt(dummyRegions.length)];
        return MeetingSummaryModel(
          meetingId: '$type-${index + 1}',
          title: '${selectedRegion['province']}' +
              (selectedRegion['district'] != null ? ' ${selectedRegion['district']}' : '') +
              ' $type 모임 ${index + 1}',
          thumbnailUrl: 'https://picsum.photos/400/400?random=$type$index',
          category: type,
          currentParticipants: (index % 10) + 1,
          maxParticipants: 10,
          price: (_random.nextInt(5) + 1) * 10000, // 10,000 ~ 50,000
          date: DateTime.now().add(Duration(days: index)), // Assign dummy date
          rating: ((index % 5) + 1).toDouble(), // Assign dummy rating (1.0 to 5.0)
          region: selectedRegion, // Populate the new region field
        );
      },
    );

    // Apply filters
    List<MeetingSummaryModel> filteredItems = allItems.where((meeting) {
      if (filterParams == null) return true;

      if (filterParams.region != null) {
        final String? filterProvince = filterParams.region!['province'];
        final String? filterDistrict = filterParams.region!['district'];

        if (filterProvince != null && meeting.region!['province'] != filterProvince) {
          return false;
        }
        if (filterDistrict != null && meeting.region!['district'] != filterDistrict) {
          return false;
        }
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

  @override
  Future<Map<String, dynamic>> getMeetingsByCategory({required String category, required int page, required int size, MeetingFilterParams? filterParams}) =>
      _generateDummyData(category, page: page, size: size, filterParams: filterParams);
}