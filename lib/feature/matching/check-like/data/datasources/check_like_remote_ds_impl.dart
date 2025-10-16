import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';

import '../models/like_user_model.dart';
import 'check_like_remote_ds.dart';

class CheckLikeRemoteDataSourceImpl implements CheckLikeRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  final String base;

  CheckLikeRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.base,
  });

  @override
  Future<List<LikeUserModel>> fetchUsersWhoLikeMe() async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/swipes/liked-me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((json) => LikeUserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users who liked me: ${response.statusCode}');
    }
  }

  @override
  Future<List<LikeUserModel>> fetchUsersILike() async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/swipes/liked-by-me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((json) => LikeUserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users I liked: ${response.statusCode}');
    }
  }
}
