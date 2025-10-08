import 'package:dartz/dartz.dart';
import 'package:soulfit_client/feature/main_profile/domain/entity/user_album_photo.dart';
import '../repository/main_profile_repository.dart';

class GetUserAlbumImagesUseCase {
  final MainProfileRepository repository;

  GetUserAlbumImagesUseCase(this.repository);

  Future<Either<Exception, List<UserAlbumPhoto>>> call(String userId) {
    return repository.getUserAlbumImages(userId);
  }
}
