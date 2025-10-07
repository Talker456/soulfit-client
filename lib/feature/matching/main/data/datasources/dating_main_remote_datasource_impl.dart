import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/recommended_user_model.dart';
import '../models/first_impression_vote_model.dart';
import 'dating_main_remote_datasource.dart';
import '../../../filter/domain/entities/dating_filter.dart'; // Import DatingFilter
import '../../../filter/data/models/dating_filter_model.dart'; // Import DatingFilterModel

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
  Future<List<RecommendedUserModel>> getRecommendedUsers(DatingFilter filter, {int limit = 10}) async {
    try {
      final token = await authSource.getAccessToken();
      
      // Convert DatingFilter to DatingFilterModel to use toQueryParameters
      final filterModel = DatingFilterModel.fromEntity(filter);
      final queryParameters = filterModel.toQueryParameters();
      
      // Add limit to query parameters
      queryParameters['size'] = limit.toString();

      final uri = Uri.http('localhost:8080', '/api/swipes/targets', queryParameters);

      final response = await client.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        print('Recommended Users Response: $responseBody');
        final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        final List<dynamic> jsonList = jsonResponse['content'];
        return jsonList.map((json) => RecommendedUserModel.fromJson(json)).toList();
      } else {
        print('Failed to load recommended users: ${response.statusCode}, body: ${response.body}');
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
      // API를 /api/votes/forms 로 변경하고, 최신 1개만 가져오도록 size=1 파라미터를 추가합니다.
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/votes/forms?page=0&size=1'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);
        final List<dynamic> content = jsonResponse['content'];

        if (content.isNotEmpty) {
          // content 리스트의 첫 번째 항목을 최신 투표로 간주하고 반환합니다.
          return FirstImpressionVoteModel.fromJson(content.first);
        } else {
          // content가 비어있으면 투표가 없는 것이므로 null을 반환합니다.
          return null;
        }
      } else if (response.statusCode == 404) {
        return null; // 404의 경우에도 투표가 없는 것으로 처리합니다.
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
        Uri.parse('http://$baseUrl:8080/api/matching/first-impression/$voteId/read'),
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