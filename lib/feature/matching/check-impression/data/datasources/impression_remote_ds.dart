import 'package:dio/dio.dart';
import '../models/impression_result_model.dart';

class ImpressionRemoteDataSource {
  final Dio dio;
  ImpressionRemoteDataSource(this.dio);

  Future<ImpressionResultModel> fetchResult(String targetUserId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return ImpressionResultModel(
      fromUserName: '파랑',
      isLiked: true,
      comment: '무심해 보이지만 은근 다정해요.',
    );
  }
}
