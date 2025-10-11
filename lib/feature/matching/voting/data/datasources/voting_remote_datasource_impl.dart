import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/vote_form_model.dart';
import '../models/vote_target_model.dart';
import '../models/vote_response_model.dart';
import '../models/vote_result_model.dart';
import 'voting_remote_datasource.dart';

/// Voting Remote DataSource 구현
/// 백엔드 API와 실제 통신을 담당
class VotingRemoteDataSourceImpl implements VotingRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  VotingRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<VoteFormModel> createVoteForm({
    required String imageUrl,
    required String title,
  }) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/votes/forms'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'imageUrl': imageUrl,
          'title': title,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        return VoteFormModel.fromJson(jsonResponse);
      } else {
        throw Exception('투표 생성에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('투표 생성 요청 실패: $e');
    }
  }

  @override
  Future<List<VoteTargetModel>> getVoteTargets(int voteFormId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/votes/forms/$voteFormId/targets'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody);

        // API 응답이 리스트인지 객체인지 확인
        List<dynamic> jsonList;
        if (jsonResponse is List) {
          jsonList = jsonResponse;
        } else if (jsonResponse is Map && jsonResponse.containsKey('content')) {
          jsonList = jsonResponse['content'] as List<dynamic>;
        } else {
          throw Exception('예상하지 못한 응답 형식');
        }

        return jsonList
            .map((json) => VoteTargetModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('투표 대상 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('투표 대상 조회 요청 실패: $e');
    }
  }

  @override
  Future<void> submitVoteResponse(VoteResponseModel response) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final httpResponse = await client.post(
        Uri.parse('http://$baseUrl:8080/api/votes/forms/${response.voteFormId}/responses'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(response.toJson()),
      );

      if (httpResponse.statusCode != 200 && httpResponse.statusCode != 201) {
        throw Exception('투표 응답 제출에 실패했습니다. 상태코드: ${httpResponse.statusCode}');
      }
    } catch (e) {
      throw Exception('투표 응답 제출 요청 실패: $e');
    }
  }

  @override
  Future<VoteResultModel> getVoteResults(int voteFormId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/votes/forms/$voteFormId/results'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        return VoteResultModel.fromJson(jsonResponse);
      } else {
        throw Exception('투표 결과 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('투표 결과 조회 요청 실패: $e');
    }
  }

  @override
  Future<VoteFormModel?> getLatestVoteForm() async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/votes/forms?page=0&size=1'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final jsonResponse = jsonDecode(responseBody) as Map<String, dynamic>;
        final List<dynamic> content = jsonResponse['content'];

        if (content.isNotEmpty) {
          return VoteFormModel.fromJson(content.first as Map<String, dynamic>);
        } else {
          return null;
        }
      } else if (response.statusCode == 404) {
        return null;
      } else {
        throw Exception('최신 투표 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('최신 투표 조회 요청 실패: $e');
    }
  }

  @override
  Future<void> markVoteFormAsRead(int voteFormId) async {
    try {
      final token = await authSource.getAccessToken();
      if (token == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      final response = await client.patch(
        Uri.parse('http://$baseUrl:8080/api/votes/forms/$voteFormId/read'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('투표 읽음 처리에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('투표 읽음 처리 요청 실패: $e');
    }
  }
}
