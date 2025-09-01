import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../../config/di/provider.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../model/ongoing_chat_model.dart';
import 'ongoing_chat_remote_data_source.dart';

class OngoingChatRemoteDataSourceImpl implements OngoingChatRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  OngoingChatRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<List<OngoingChatModel>> getOngoingChats(int page, int size) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$BASE_URL:8080/api/chat/rooms/my?page=$page&size=$size'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      print('##### Server Response for Ongoing Chats: $responseBody');
      final Map<String, dynamic> data = jsonDecode(responseBody);
      final List<dynamic> content = data['content'];
      return content.map((json) => OngoingChatModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load ongoing chats');
    }
  }
}