
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';

import '../model/user_album_photo_dto.dart';
import '../model/user_main_profile_info_dto.dart';
import '../model/user_value_analysis_dto.dart';
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
    final response = await client.get(
      Uri.parse('http://$base:8080/api/profile/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('[Debug] Response Status Code: ${response.statusCode}');
    print('[Debug] Response Body: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // API spec has 'bio', DTO has 'introduction'.
      // API spec does not have 'selfKeywords'.
      return UserMainProfileInfoDto(
        profileImageUrl: jsonResponse['profileImageUrl'],
        introduction: jsonResponse['bio'] ?? '', // Mapping bio to introduction
        personalityKeywords:
            List<String>.from(jsonResponse['personalityKeywords'] ?? []),
        selfKeywords: [], // Not provided by API, defaulting to empty list
      );
    } else {
      throw Exception('Failed to load main profile info');
    }
  }

  @override
  Future<List<String>> fetchUserAlbumImages(String userId) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/profile/$userId/photos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((photoJson) => UserAlbumPhotoDto.fromJson(photoJson).imageUrl)
          .toList();
    } else {
      throw Exception('Failed to load user album images');
    }
  }

  @override
  Future<List<String>> fetchAIPredictedKeywords(String userId) {
    throw UnimplementedError('API for AI predicted keywords is not defined.');
  }

  @override
  Future<bool> fetchCanViewDetailedValueAnalysis(
      {required String viewerUserId, required String targetUserId}) {
    throw UnimplementedError('API for canViewDetailedValueAnalysis is not defined.');
  }

  @override
  Future<List<String>> fetchPerceivedByOthersKeywords(String userId) {
    throw UnimplementedError('API for perceived by others keywords is not defined.');
  }

  @override
  Future<UserValueAnalysisDto> fetchUserValueAnalysis(String userId) {
    throw UnimplementedError('API for user value analysis is not defined.');
  }
}
