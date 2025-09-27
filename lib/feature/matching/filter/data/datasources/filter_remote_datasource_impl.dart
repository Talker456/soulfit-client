import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/dating_filter_model.dart';
import '../models/filtered_user_model.dart';
import 'filter_remote_datasource.dart';

class FilterRemoteDataSourceImpl implements FilterRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  FilterRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<List<FilteredUserModel>> getFilteredUsers(DatingFilterModel filter) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.post(
        Uri.parse('https://$baseUrl:8443/api/matching/filter'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(filter.toJson()),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => FilteredUserModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to get filtered users: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process getFilteredUsers: $e');
    }
  }
}