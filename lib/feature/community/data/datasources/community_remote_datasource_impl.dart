import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/post.dart';
import '../../domain/entities/comment.dart';
import '../../../authentication/data/datasource/auth_local_datasource.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import 'community_remote_datasource.dart';

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final http.Client client;
  final AuthLocalDataSource authSource;
  final String baseUrl;

  CommunityRemoteDataSourceImpl({
    required this.client,
    required this.authSource,
    required this.baseUrl,
  });

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.get(
        Uri.parse('https://$baseUrl:8443/api/community/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process getPosts: $e');
    }
  }

  @override
  Future<PostModel> createPost({
    required String content,
    String? imageUrl,
    required String postType,
  }) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.post(
        Uri.parse('https://$baseUrl:8443/api/community/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'content': content,
          'imageUrl': imageUrl,
          'postType': postType,
        }),
      );

      if (response.statusCode == 201) {
        return PostModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process createPost: $e');
    }
  }

  @override
  Future<void> likePost(String postId) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.post(
        Uri.parse('https://$baseUrl:8443/api/community/posts/$postId/like'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to like post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process likePost: $e');
    }
  }

  @override
  Future<void> unlikePost(String postId) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.delete(
        Uri.parse('https://$baseUrl:8443/api/community/posts/$postId/like'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to unlike post: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process unlikePost: $e');
    }
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.get(
        Uri.parse('https://$baseUrl:8443/api/community/posts/$postId/comments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load comments: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process getComments: $e');
    }
  }

  @override
  Future<CommentModel> createComment({
    required String postId,
    required String content,
  }) async {
    try {
      final token = await authSource.getAccessToken();
      final response = await client.post(
        Uri.parse('https://$baseUrl:8443/api/community/posts/$postId/comments'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
          'content': content,
        }),
      );

      if (response.statusCode == 201) {
        return CommentModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create comment: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect or process createComment: $e');
    }
  }
}