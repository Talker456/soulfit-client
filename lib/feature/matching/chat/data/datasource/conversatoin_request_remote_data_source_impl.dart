
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/matching/chat/data/datasource/conversation_request_remote_data_source.dart';
import 'package:soulfit_client/feature/matching/chat/data/model/chat_request_model.dart';
import 'package:soulfit_client/feature/matching/chat/data/model/sent_chat_request_model.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';

class ConversationRequestRemoteDataSourceImpl
    implements ConversationRequestRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String base;

  ConversationRequestRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.base,
  });

  @override
  Future<void> acceptRequest(int requestId) async {
    final token = await source.getAccessToken();
    final response = await client.patch(
      Uri.parse('http://$base:8080/api/conversations/requests/$requestId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'status': 'ACCEPTED'}),
    );

    print('[conversation_req request remote data source impl] : accept request $requestId');
    if (response.statusCode != 200) {
      throw Exception('Failed to accept conversation_req request');
    }
  }

  @override
  Future<void> rejectRequest(int requestId) async {
    final token = await source.getAccessToken();
    final response = await client.patch(
      Uri.parse('http://$base:8080/api/conversations/requests/$requestId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'status': 'REJECTED'}),
    );

    print('[conversation_req request remote data source impl] : reject request $requestId');
    if (response.statusCode != 200) {
      throw Exception('Failed to reject conversation_req request');
    }
  }

  @override
  Future<SentChatRequestModel> sendRequest(
      {required int toUserId, required String message}) async {
    final token = await source.getAccessToken();
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
      print('[conversation_req request remote data source impl] : send request $message');
      return SentChatRequestModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send conversation_req request');
    }
  }

  @override
  Future<List<ChatRequestModel>> getReceivedRequests() async {
    final token = await source.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/conversations/requests/received?status=PENDING'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('[Debug] Response Status Code: ${response.statusCode}');
    print('[Debug] Response Body: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      print('[conversation_req request remote data source impl] : get received requests');
      try{
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data.map((json) => ChatRequestModel.fromJson(json)).toList();
      }catch(e){
        print('[Debug] JSON Parsing or Model Conversion Error: $e'); // 에러 로그 추가
        throw Exception('Failed to parse conversation_req requests');
      }
    } else {
      print('[conversation_req request remote data source impl] : failed to get received requests');
      print('[response] : $response');
      throw Exception('Failed to load received requests');
    }
  }

  @override
  Future<List<SentChatRequestModel>> getSentRequests() async {
    final token = await source.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/conversations/requests/sent?status=PENDING'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('[conversation_req request remote data source impl] : get sent requests $token');
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      return data.map((json) => SentChatRequestModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load sent requests');
    }
  }
}
