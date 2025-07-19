import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain/entity/notification_entity.dart';
import 'noti_remote_datasource.dart';

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final http.Client client;

  NotificationRemoteDataSourceImpl(this.client);

  @override
  Future<List<NotificationEntity>> fetchNotifications({int page = 1, int limit = 20}) async {
    final response = await client.get(Uri.parse('https://your.api/notifications?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => NotificationEntity(
        id: json['id'],
        type: json['type'],
        title: json['title'],
        body: json['body'],
        targetId: json['targetId'],
        createdAt: DateTime.parse(json['createdAt']),
        isRead: json['isRead'],
      )).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    final response = await client.patch(
      Uri.parse('https://your.api/notifications/$notificationId/read'),
    );
    if (response.statusCode != 200) throw Exception('Failed to mark as read');
  }

  @override
  Future<void> markAllAsRead() async {
    final response = await client.patch(
      Uri.parse('https://your.api/notifications/read-all'),
    );
    if (response.statusCode != 200) throw Exception('Failed to mark all as read');
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    final response = await client.delete(
      Uri.parse('https://your.api/notifications/$notificationId'),
    );
    if (response.statusCode != 200) throw Exception('Failed to delete notification');
  }
}
