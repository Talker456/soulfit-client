import 'package:dio/dio.dart';
import 'package:soulfit_client/feature/dating_profile/data/model/dating_profile_model.dart';
import 'dating_profile_fake_datasource.dart';

class DatingProfileRemoteDataSource implements DatingProfileDataSource {
  final Dio dio;
  DatingProfileRemoteDataSource(this.dio);

  @override
  Future<DatingProfileModel> getProfile(
      {required String viewerUserId, required String targetUserId}) async {
    final res = await dio.get('/dating/profile/$targetUserId?viewerId=$viewerUserId');
    return DatingProfileModel.fromJson(res.data as Map<String, dynamic>);
  }
}
