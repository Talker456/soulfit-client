import 'package:dartz/dartz.dart';
import '../repository/main_profile_repository.dart';

class GetUserAlbumImagesUseCase {
  final MainProfileRepository repository;

  GetUserAlbumImagesUseCase(this.repository);

  Future<Either<Exception, List<String>>> call(String userId) {
    return repository.getUserAlbumImages(userId);
  }
}
