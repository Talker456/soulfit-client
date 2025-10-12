import 'package:dio/dio.dart';
import '../models/like_user_model.dart';

class CheckLikeRemoteDataSource {
  final Dio dio;
  CheckLikeRemoteDataSource(this.dio);

  Future<List<LikeUserModel>> fetchUsersWhoLikeMe(List<String> filters) async {
    final res = await dio.get(
      '/likes/liked-me',
      queryParameters: {'filters': filters},
    );
    final list = (res.data as List).cast<Map<String, dynamic>>();
    return list.map(LikeUserModel.fromJson).toList();
  }

  Future<List<LikeUserModel>> fetchUsersILike(
    List<String> filters, {
    String sub = 'viewed',
  }) async {
    final res = await dio.get(
      '/likes/i-like',
      queryParameters: {'filters': filters, 'sub': sub},
    );
    final list = (res.data as List).cast<Map<String, dynamic>>();
    return list.map(LikeUserModel.fromJson).toList();
  }
}
