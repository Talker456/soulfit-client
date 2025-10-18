import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_message_model.dart';

import 'chat_detail_remote_data_source.dart';

class ChatDetailRemoteDataSourceImpl implements ChatDetailRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;

  ChatDetailRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
  });

  @override
  Future<List<ChatMessageModel>> getMessages(String roomId, int page, int size) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$BASE_URL:8080/api/chat/rooms/$roomId/messages?page=$page&size=$size'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      final List<dynamic> content = data['content'];
      return content.map((json) => ChatMessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  @override
  Future<ChatMessageModel> sendImage(String roomId, File image) async {
    final token = await authLocalDataSource.getAccessToken();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://$BASE_URL:8080/api/chat/rooms/$roomId/images'),
    );
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('images', image.path));

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> data = jsonDecode(responseBody);
      return ChatMessageModel.fromJson(data);
    } else {
      throw Exception('Failed to send image');
    }
  }

  @override
  Future<void> leaveChatRoom(String roomId) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.delete(
      Uri.parse('http://$BASE_URL:8080/api/chat/rooms/$roomId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to leave chat room');
    }
  }

  @override
  Future<void> readChatRoom(String roomId) async {
    print('##### [ChatDetailRemoteDataSource] Reading chat room: $roomId');
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.post(
      Uri.parse('http://$BASE_URL:8080/api/chat/$roomId/read'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('##### [ChatDetailRemoteDataSource] Successfully read chat room: $roomId, status: ${response.statusCode}');
    } else {
      print('##### [ChatDetailRemoteDataSource] Failed to read chat room: $roomId, status: ${response.statusCode}');
      throw Exception('Failed to mark chat room as read');
    }
  }
}
