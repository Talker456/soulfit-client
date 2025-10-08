
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';

import '../model/conversation_request_dto.dart';
import 'conversation_remote_datasource.dart';

class ConversationRemoteDataSourceImpl implements ConversationRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  final String base;

  ConversationRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.base,
  });

  @override
  Future<ConversationRequestDto> sendConversationRequest({
    required int toUserId,
    required String message,
  }) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.post(
      Uri.parse('http://$base:8080/api/conversations/requests'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'toUserId': toUserId,
        'message': message,
      }),
    );

    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      return ConversationRequestDto.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to send conversation_req request');
    }
  }
}
