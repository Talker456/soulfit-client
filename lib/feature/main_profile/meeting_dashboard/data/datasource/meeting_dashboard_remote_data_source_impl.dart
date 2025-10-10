import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import './meeting_dashboard_remote_data_source.dart';
import '../model/meeting_dashboard_stats_model.dart';
import '../model/paginated_meetings_model.dart';

class MeetingDashboardRemoteDataSourceImpl implements MeetingDashboardRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String base;

  MeetingDashboardRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.base,
  });

  @override
  Future<MeetingDashboardStatsModel> getMeetingDashboardStats() async {
    final token = await source.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/meeting/dashboard'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return MeetingDashboardStatsModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load meeting dashboard stats');
    }
  }

  @override
  Future<PaginatedMeetingsModel> getParticipatedMeetings({required int page, required int size}) async {
    final token = await source.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$base:8080/api/me/meetings/participated?page=$page&size=$size'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return PaginatedMeetingsModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load participated meetings');
    }
  }
}
