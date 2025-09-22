
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/meeting/main/data/datasource/meeting_remote_data_source.dart';
import 'package:soulfit_client/feature/meeting/main/data/model/meeting_summary_model.dart';
import 'package:soulfit_client/feature/meeting/main/domain/entity/meeting_filter_params.dart';

class MeetingRemoteDataSourceImpl implements MeetingRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl = 'http://localhost:8080/api';

  MeetingRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
  });

  Future<Map<String, String>> _getHeaders() async {
    final accessToken = await authSource.getAccessToken() as String;
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + accessToken,
    };
  }

  @override
  Future<Map<String, dynamic>> getAiRecommendedMeetings({required int page, required int size, MeetingFilterParams? filterParams}) async {
    final headers = await _getHeaders();
    final uri = Uri.parse('$baseUrl/meetings/recommended');
    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      final meetings = body.map((data) => MeetingSummaryModel.fromServerJson(data)).toList();
      
      // Extract recommendationReasons as tags
      final tags = body.isNotEmpty && body.first['recommendationReasons'] != null
          ? List<String>.from(body.first['recommendationReasons'])
          : <String>[];

      return {'meetings': meetings, 'tags': tags};
    } else {
      throw Exception('Failed to load AI recommended meetings');
    }
  }

  @override
  Future<Map<String, dynamic>> getPopularMeetings({required int page, required int size, MeetingFilterParams? filterParams}) async {
    return _getMeetingsPage(
      endpoint: '/meetings',
      page: page,
      size: size,
      sort: 'currentParticipants,desc',
      filterParams: filterParams,
    );
  }

  @override
  Future<Map<String, dynamic>> getRecentlyCreatedMeetings({required int page, required int size, MeetingFilterParams? filterParams}) async {
    return _getMeetingsPage(
      endpoint: '/meetings',
      page: page,
      size: size,
      sort: 'createdAt,desc',
      filterParams: filterParams,
    );
  }

  @override
  Future<Map<String, dynamic>> getUserRecentJoinedMeetings({required int page, required int size, MeetingFilterParams? filterParams}) async {
    return _getMeetingsPage(
      endpoint: '/me/meetings/participated',
      page: page,
      size: size,
      filterParams: filterParams,
    );
  }

  @override
  Future<Map<String, dynamic>> getMeetingsByCategory({required String category, required int page, required int size, MeetingFilterParams? filterParams}) async {
    final combinedFilters = (filterParams ?? const MeetingFilterParams()).copyWith(category: category);
    return _getMeetingsPage(
      endpoint: '/meetings/filter',
      page: page,
      size: size,
      filterParams: combinedFilters,
    );
  }

  // Helper method to fetch a page of meetings
  Future<Map<String, dynamic>> _getMeetingsPage({
    required String endpoint,
    required int page,
    required int size,
    String? sort,
    MeetingFilterParams? filterParams,
  }) async {
    final headers = await _getHeaders();
    final queryParameters = _buildFilterParams(page, size, filterParams, sort);
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);

    // 1. 요청 URI 로깅
    print('[MeetingDataSource] Requesting URI: ${Uri.decodeFull(uri.toString())}');

    final response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> content = body['content'];
      final meetings = content.map((data) => MeetingSummaryModel.fromServerJson(data)).toList();
      
      // 2. 성공 결과 로깅
      print('[MeetingDataSource] Successfully fetched ${meetings.length} meetings from $endpoint.');

      return {'meetings': meetings, 'tags': []};
    } else {
      // 3. 에러 로깅
      print('[MeetingDataSource] Failed to load meetings from $endpoint. Status code: ${response.statusCode}');
      throw Exception('Failed to load meetings from $endpoint');
    }
  }

  Map<String, String> _buildFilterParams(int page, int size, MeetingFilterParams? filters, String? sort) {
    final params = <String, String>{
      'page': page.toString(),
      'size': size.toString(),
    };
    if (sort != null) {
      params['sort'] = sort;
    }
    if (filters == null) return params;

    if (filters.category != null) params['category'] = filters.category!;
    if (filters.region?['province'] != null) params['city'] = filters.region!['province']!;
    
    // Note: The spec does not explicitly define these filters.
    // This is an assumption based on the app's functionality.
    // This may need to be confirmed with the backend team.
    if (filters.minPrice != null) params['minFee'] = filters.minPrice!.round().toString();
    if (filters.maxPrice != null) params['maxFee'] = filters.maxPrice!.round().toString();
    if (filters.minRating != null) params['minRating'] = filters.minRating!.toString();

    return params;
  }
}
