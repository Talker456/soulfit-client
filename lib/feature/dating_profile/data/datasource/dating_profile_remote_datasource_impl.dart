import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_fake_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/model/dating_profile_model.dart';


class DatingProfileRemoteDataSourceImpl implements DatingProfileDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  final String base;

  DatingProfileRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.base,
  });

  @override
  Future<DatingProfileModel> getProfile(String userId) async {
    final token = await authLocalDataSource.getAccessToken();
    // Use the correct endpoint for fetching a specific user's profile
    final response = await client.get(
      Uri.parse('http://$base:8080/api/matching-profiles/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // 서버로부터 받은 원본 응답(문자열)을 확인하기 위한 print문
      print('✅ Raw JSON response: ${utf8.decode(response.bodyBytes)}');
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      print('✅ Parsed JSON (Map): $jsonResponse');
      return DatingProfileModel.fromJson(jsonResponse);
    } else {
          throw Exception('Failed to load main profile info: ${response.statusCode}');
    }
  }
}