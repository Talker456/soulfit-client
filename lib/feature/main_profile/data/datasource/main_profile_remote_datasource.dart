import '../model/user_main_profile_info_dto.dart';
import '../model/user_value_analysis_dto.dart';

abstract class MainProfileRemoteDataSource {
  Future<UserMainProfileInfoDto> fetchUserMainProfileInfo(String userId);
  Future<List<String>> fetchPerceivedByOthersKeywords(String userId);
  Future<List<String>> fetchAIPredictedKeywords(String userId);
  Future<UserValueAnalysisDto> fetchUserValueAnalysis(String userId);
  Future<List<String>> fetchUserAlbumImages(String userId);
  Future<bool> fetchCanViewDetailedValueAnalysis({
    required String viewerUserId,
    required String targetUserId,
  });
}
