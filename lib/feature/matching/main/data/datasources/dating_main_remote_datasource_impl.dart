import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/recommended_user_model.dart';
import '../models/first_impression_vote_model.dart';
import 'dating_main_remote_datasource.dart';

class DatingMainRemoteDataSourceImpl implements DatingMainRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  DatingMainRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<List<RecommendedUserModel>> getRecommendedUsers({int limit = 10}) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.get(
        Uri.parse('https://$baseUrl:8443/api/matching/recommended?limit=$limit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => RecommendedUserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recommended users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process getRecommendedUsers: $e');
    }
  }

  @override
  Future<FirstImpressionVoteModel?> getLatestFirstImpressionVote() async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.get(
        Uri.parse('https://$baseUrl:8443/api/matching/first-impression/latest'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json != null ? FirstImpressionVoteModel.fromJson(json) : null;
      } else if (response.statusCode == 404) {
        return null; // 투표가 없는 경우
      } else {
        throw Exception('Failed to load first impression vote: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process getLatestFirstImpressionVote: $e');
    }
  }

  @override
  Future<void> markFirstImpressionVoteAsRead(String voteId) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.patch(
        Uri.parse('https://$baseUrl:8443/api/matching/first-impression/$voteId/read'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to mark vote as read: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process markFirstImpressionVoteAsRead: $e');
    }
  }
}