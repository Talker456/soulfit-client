import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/review_model.dart';
import 'review_remote_datasource.dart';

/// 리뷰 Remote DataSource 구현
/// 백엔드 API와 실제 통신을 담당
class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  ReviewRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<List<ReviewModel>> getReviews(String meetingId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - GET /api/meetings/{meetingId}/reviews
      // - GET /api/reviews?meetingId={meetingId}
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/meetings/$meetingId/reviews'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(responseBody);

        if (jsonData is List) {
          return jsonData.map((json) => ReviewModel.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('리뷰 목록 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('리뷰 목록 요청 실패: $e');
    }
  }

  @override
  Future<ReviewStatsModel> getReviewStats(String meetingId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - GET /api/meetings/{meetingId}/reviews/stats
      // - GET /api/meetings/{meetingId}/stats
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/meetings/$meetingId/reviews/stats'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(responseBody);

        return ReviewStatsModel.fromJson(jsonData);
      } else {
        throw Exception('평점 통계 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('평점 통계 요청 실패: $e');
    }
  }

  @override
  Future<String> createReview(CreateReviewRequestModel request) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 명세 확인 필요
      // 예상 엔드포인트:
      // - POST /api/meetings/{meetingId}/reviews
      // - POST /api/reviews
      //
      // 요청 본문에서 meetingId를 제거하고 URL에만 포함할 수도 있음
      final requestBody = request.toJson();
      requestBody.remove('meetingId'); // meetingId는 URL에 포함

      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/meetings/${request.meetingId}/reviews'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody);

        // 응답에서 생성된 리뷰 ID 추출
        // TODO: API 응답 형식에 따라 수정 필요
        if (jsonResponse is Map<String, dynamic>) {
          return jsonResponse['id']?.toString() ??
              jsonResponse['reviewId']?.toString() ??
              '';
        }
        return '';
      } else {
        throw Exception('리뷰 작성 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('리뷰 작성 요청 실패: $e');
    }
  }
}
