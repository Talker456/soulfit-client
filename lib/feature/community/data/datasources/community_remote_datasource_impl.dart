import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/paginated_posts_model.dart';
import 'community_remote_datasource.dart';

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource source;
  final String baseUrl;

  CommunityRemoteDataSourceImpl({
    required this.client,
    required this.source,
    required this.baseUrl,
  });

  @override
  Future<PostModel> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  }) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: POST /api/posts 또는 /api/community/posts
      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/posts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'content': content,
          'imageUrl': imageUrl,
          'postType': postType,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return PostModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
        );
      } else {
        throw Exception('포스트 작성에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginatedPostsModel> getPosts({
    required int page,
    required int size,
    String? postType,
  }) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: GET /api/posts?page={page}&size={size}&postType={postType}
      final queryParams = {
        'page': page.toString(),
        'size': size.toString(),
        if (postType != null) 'postType': postType,
      };

      final uri = Uri.parse('http://$baseUrl:8080/api/posts')
          .replace(queryParameters: queryParams);

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return PaginatedPostsModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
        );
      } else {
        throw Exception('포스트 목록 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostModel> getPost(String postId) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: GET /api/posts/{id}
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/posts/$postId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        return PostModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
        );
      } else {
        throw Exception('포스트 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> createComment({
    required String postId,
    required String content,
  }) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: POST /api/posts/{id}/comments
      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/posts/$postId/comments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'content': content,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CommentModel.fromJson(
          jsonDecode(utf8.decode(response.bodyBytes)),
        );
      } else {
        throw Exception('댓글 작성에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: GET /api/posts/{id}/comments
      final response = await client.get(
        Uri.parse('http://$baseUrl:8080/api/posts/$postId/comments'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(utf8.decode(response.bodyBytes));
        return jsonList
            .map((json) => CommentModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('댓글 목록 조회에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> likePost(String postId) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: POST /api/posts/{id}/like
      final response = await client.post(
        Uri.parse('http://$baseUrl:8080/api/posts/$postId/like'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201 && response.statusCode != 204) {
        throw Exception('좋아요에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> unlikePost(String postId) async {
    try {
      final accessToken = await source.getAccessToken();
      if (accessToken == null) {
        throw Exception('인증 토큰이 없습니다.');
      }

      // TODO: 백엔드 API 엔드포인트 확인 필요
      // 예상 엔드포인트: DELETE /api/posts/{id}/like
      final response = await client.delete(
        Uri.parse('http://$baseUrl:8080/api/posts/$postId/like'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('좋아요 취소에 실패했습니다. 상태코드: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
