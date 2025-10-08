import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';

import '../model/user_album_photo_dto.dart';
import '../model/user_main_profile_info_dto.dart';
import '../model/user_value_analysis_dto.dart';
import '../model/value_chart_dto.dart';
import 'main_profile_remote_datasource.dart';

class MainProfileRemoteDataSourceImpl implements MainProfileRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  final String base;

  MainProfileRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.base,
  });

  @override
  Future<UserMainProfileInfoDto> fetchUserMainProfileInfo(String userId) async {
    final token = await authLocalDataSource.getAccessToken();
    // Use the correct endpoint for fetching a specific user's profile
    final response = await client.get(
      Uri.parse('http://$base:8080/api/profile/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return UserMainProfileInfoDto.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load main profile info: ${response.statusCode}');
    }
  }

  @override
  Future<List<UserAlbumPhotoDto>> fetchUserAlbumImages(String userId) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/profile/$userId/photos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonResponse
          .map((photoJson) => UserAlbumPhotoDto.fromJson(photoJson))
          .toList();
    } else {
      throw Exception('Failed to load user album images');
    }
  }

  @override
  Future<List<String>> fetchAIPredictedKeywords(String userId) async {
    // TODO: API for AI predicted keywords is not defined. Using dummy data.
    await Future.delayed(const Duration(milliseconds: 200)); // Simulate network delay
    return ['지적인', '통찰력 있는', '개성있는'];
  }

  @override
  Future<bool> fetchCanViewDetailedValueAnalysis(
      {required String viewerUserId, required String targetUserId}) async {
    // TODO: API for checking detailed value analysis view permission is not defined. Using dummy data.
    await Future.delayed(const Duration(milliseconds: 200)); // Simulate network delay
    return true; // Defaulting to true for now.
  }

  @override
  Future<List<String>> fetchPerceivedByOthersKeywords(String userId) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/reviews/user/$userId/keywords/summary'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> jsonResponse = jsonDecode(decodedBody);
      return List<String>.from(jsonResponse);
    } else {
      throw Exception('Failed to load perceived by others keywords');
    }
  }

  @override
  Future<UserValueAnalysisDto> fetchUserValueAnalysis(String userId) async {
    // TODO: API for user value analysis is not defined. Using dummy data.
    await Future.delayed(const Duration(milliseconds: 200)); // Simulate network delay
    return UserValueAnalysisDto(
      summary: '긍정적이고 안정적인 관계를 추구하며, 높은 수준의 사회적 책임감을 가지고 있습니다. '
          '다양한 관점을 존중하고 새로운 경험에 개방적이지만, 때로는 내면의 감정을 표현하는 데 신중한 모습을 보입니다.',
      chartA: [
        ValueChartDto(label: '안정성', score: 0.8),
        ValueChartDto(label: '개방성', score: 0.6),
        ValueChartDto(label: '책임감', score: 0.9),
      ],
      chartB: [
        ValueChartDto(label: '유머', score: 0.7),
        ValueChartDto(label: '사교성', score: 0.5),
        ValueChartDto(label: '논리', score: 0.85),
      ],
    );
  }
}
