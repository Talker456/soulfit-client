import 'package:dartz/dartz.dart';
import '../entity/user_album_photo.dart';
import '../entity/user_main_profile_info.dart';
import '../entity/user_value_analysis.dart';

abstract class MainProfileRepository {
  Future<Either<Exception, UserMainProfileInfo>> getUserMainProfileInfo(String userId);

  Future<Either<Exception, List<String>>> getPerceivedByOthersKeywords(String userId);

  Future<Either<Exception, List<String>>> getAIPredictedKeywords(String userId);

  Future<Either<Exception, UserValueAnalysis>> getUserValueAnalysis(String userId);

  Future<Either<Exception, List<UserAlbumPhoto>>> getUserAlbumImages(String userId);

  Future<Either<Exception, bool>> canViewDetailedValueAnalysis({
    required String viewerUserId,
    required String targetUserId,
  });
}
