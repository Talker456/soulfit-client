import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/dating_filter_model.dart';
import '../models/filtered_user_model.dart';
import 'filter_remote_datasource.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class FilterRemoteDataSourceImpl implements FilterRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  // baseUrl is not used in the proposed change, but kept for consistency.
  // final String baseUrl;

  FilterRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required String baseUrl, // kept parameter for DI compatibility
  });

  @override
  Future<List<FilteredUserModel>> getFilteredUsers(DatingFilterModel filter) async {
    try {
      final token = await authSource.getAccessToken();

      // Convert filter model to query parameters
      final queryParameters = filter.toQueryParameters();

      // Create URI with the correct endpoint and query parameters
      final uri = Uri.http('localhost:8080', '/api/swipes/targets', queryParameters);

      debugPrint('[FilterRemoteDataSource] Requesting: $uri');
      debugPrint('[FilterRemoteDataSource] Headers: {Authorization: Bearer $token}');

      // Make the GET request
      final response = await client.get(
        uri,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('[FilterRemoteDataSource] Response Status Code: ${response.statusCode}');
      debugPrint('[FilterRemoteDataSource] Response Body: ${utf8.decode(response.bodyBytes)}');

      if (response.statusCode == 200) {
        // Decode the paginated response and access the 'content' list
        final Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final List<dynamic> jsonList = jsonResponse['content'];
        debugPrint('[FilterRemoteDataSource] Parsed content list length: ${jsonList.length}');
        return jsonList.map((json) => FilteredUserModel.fromJson(json)).toList();
      } else {
        debugPrint('[FilterRemoteDataSource] Failed with status: ${response.statusCode}, Body: ${utf8.decode(response.bodyBytes)}');
        throw Exception('Failed to get filtered users: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('[FilterRemoteDataSource] Error in getFilteredUsers: $e');
      throw Exception('Failed to connect or process getFilteredUsers: $e');
    }
  }
}