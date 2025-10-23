import 'package:dio/dio.dart';
import '../models/submit_feedback_req.dart';

class ImpressionRemoteDataSource {
  final Dio dio;
  ImpressionRemoteDataSource(this.dio);

  Future<String> submit(SubmitFeedbackReq req) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return 'fbk_mock_id_123';
  }
}
