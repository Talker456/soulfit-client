
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/matching/review/data/datasource/review_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/review/data/model/create_review_request_dto.dart';
import 'package:soulfit_client/feature/matching/review/data/model/review_response_dto.dart';

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authLocalDataSource;
  final String baseUrl;

  ReviewRemoteDataSourceImpl({
    required this.client,
    required this.authLocalDataSource,
    required this.baseUrl,
  });


  @override
  Future<ReviewResponseDto> createReview(CreateReviewRequestDto request) async {
    final token = await authLocalDataSource.getAccessToken();
    String uri = 'http://$baseUrl:8080/api/reviews';

    print('request : '+ request.toJson().toString());
    final response = await client.post(
      Uri.parse(uri),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(request.toJson()),
    );


    if (response.statusCode == 201) {
      return ReviewResponseDto.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create review: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<List<ReviewResponseDto>> getReviewsForUser(int userId) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$baseUrl:8080/api/reviews/user/$userId'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ReviewResponseDto.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get reviews for user: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<List<ReviewResponseDto>> getMyReviews() async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$baseUrl:8080/api/reviews/my'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ReviewResponseDto.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get my reviews: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<List<String>> getReviewKeywords() async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$baseUrl:8080/api/reviews/keywords'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<String>().toList();
    } else {
      throw Exception('Failed to get review keywords: ${response.statusCode} ${response.body}');
    }
  }

  @override
  Future<List<String>> getUserKeywordSummary(int userId) async {
    final token = await authLocalDataSource.getAccessToken();
    final response = await client.get(
      Uri.parse('http://$baseUrl:8080/api/reviews/user/$userId/keywords/summary'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<String>().toList();
    } else {
      throw Exception('Failed to get user keyword summary: ${response.statusCode} ${response.body}');
    }
  }
}
