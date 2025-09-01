import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/notification/data/datasource/noti_remote_datasource.dart';
import 'dart:convert';

import '../../domain/entity/notification_entity.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource  {

  final http.Client client;
  final AuthLocalDataSource source;
  final String base;

  NotificationRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.base,
  });


  @override
  Future<List<NotificationEntity>> fetchNotifications({int page = 1, int limit = 20}) async {
    final accessToken = await source.getAccessToken() as String;

    final response = await client.get(
        Uri.parse('http://localhost:8080/api/notifications?page=$page&limit=$limit'),
        headers: <String,String>{
          'Authorization': 'Bearer '+accessToken,
        },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      for (var item in jsonList) {
        print(item);
      }



      return jsonList.map((json) => NotificationEntity(
        id: json['id'].toString(),
        type: json['type'],
        title: json['title'],
        body: json['body'],
        targetId: json['targetId'].toString(),
        createdAt: DateTime.parse(json['createdAt']),
        read: json['read'] as bool,
        senderProfileImageUrl: json['senderProfileImageUrl'],
      )).toList();
    } else {
      throw Exception('Failed to load notifications');
    }

  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final accessToken = await source.getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    print('[noti remote data src impl] : notificationID ($notificationId) marking as read');
    final response = await client.post(
      Uri.parse('http://$base:8080/api/notifications/$notificationId/read'),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+accessToken,
      },
    );
    if (response.statusCode != 200){
      print('[noti remote data src impl] : failed to mark as read, '+response.statusCode.toString());
      throw Exception('Failed to mark as read');
    }

    print('[noti remote dats src impl] : $notificationId noti marked as read');
  }

  @override
  Future<void> markAllAsRead() async {
    final accessToken = await source.getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    final response = await client.post(
      Uri.parse('https://$base:8080/api/notifications/read-all'),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=UTF-8',
        'Authorization': 'Bearer '+accessToken,
      },
    );
    if (response.statusCode != 200) throw Exception('Failed to mark all as read');
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final accessToken = await source.getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token is null');
    }

    final response = await client.delete(
      Uri.parse('https://your.api/notifications/$notificationId'),
      headers: <String,String>{
        'Authorization': 'Bearer '+accessToken,
      },
    );
    if (response.statusCode != 200) throw Exception('Failed to delete notification');
  }
}
