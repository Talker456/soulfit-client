import 'package:dartz/dartz.dart';
import '../entity/user_profile_screen_data.dart';
import '../repository/main_profile_repository.dart';

class LoadUserProfileScreenDataUseCase {
  final MainProfileRepository repository;

  LoadUserProfileScreenDataUseCase(this.repository);

  Future<Either<Exception, UserProfileScreenData>> call({
    required String viewerUserId,
    required String targetUserId,
  }) async {
    try {
      final results = await Future.wait([
        repository.getUserMainProfileInfo(targetUserId),
        repository.getPerceivedByOthersKeywords(targetUserId),
        repository.getAIPredictedKeywords(targetUserId),
        repository.getUserValueAnalysis(targetUserId),
        repository.getUserAlbumImages(targetUserId),
        repository.canViewDetailedValueAnalysis(
          viewerUserId: viewerUserId,
          targetUserId: targetUserId,
        ),
      ]);

      if (results.any((res) => res.isLeft())) {
        final firstError = results.firstWhere((res) => res.isLeft()) as Left;
        return Left(firstError.value);
      }

      final data = UserProfileScreenData(
        mainProfileInfo: (results[0] as Right).value,
        perceivedByOthersKeywords: (results[1] as Right).value,
        aiPredictedKeywords: (results[2] as Right).value,
        valueAnalysis: (results[3] as Right).value,
        albumImages: (results[4] as Right).value,
        canViewDetailedValue: (results[5] as Right).value,
      );

      return Right(data);
    } catch (e) {
      return Left(Exception('Failed to load profile data: $e'));
    }
  }
}
