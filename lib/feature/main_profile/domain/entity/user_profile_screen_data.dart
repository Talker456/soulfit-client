import './user_album_photo.dart';
import 'user_main_profile_info.dart';
import 'user_value_analysis.dart';

class UserProfileScreenData {
  final UserMainProfileInfo mainProfileInfo;
  final List<String> perceivedByOthersKeywords;
  final List<String> aiPredictedKeywords;
  final UserValueAnalysis valueAnalysis;
  final List<UserAlbumPhoto> albumImages;
  final bool canViewDetailedValue;

  UserProfileScreenData({
    required this.mainProfileInfo,
    required this.perceivedByOthersKeywords,
    required this.aiPredictedKeywords,
    required this.valueAnalysis,
    required this.albumImages,
    required this.canViewDetailedValue,
  });
}
