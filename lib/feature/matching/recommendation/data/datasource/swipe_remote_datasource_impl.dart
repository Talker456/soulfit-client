
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/matching/recommendation/data/datasource/swipe_remote_datasource.dart';

class SwipeRemoteDataSourceImpl implements SwipeRemoteDataSource {
  final http.Client _client;
  final AuthLocalDataSource _authLocalDataSource;

  SwipeRemoteDataSourceImpl({
    required http.Client client,
    required AuthLocalDataSource authLocalDataSource,
  })  : _client = client,
        _authLocalDataSource = authLocalDataSource;

  @override
  Future<void> sendSwipe({required int userId, required bool isLike}) async {
    final token = await _authLocalDataSource.getAccessToken();
    final response = await _client.post(
      Uri.parse('http://$BASE_URL:8080/api/swipes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'targetUserId': userId,
        'choice': isLike ? 'LIKE' : 'PASS',
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to send swipe action');
    }
  }
}
