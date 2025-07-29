import 'package:dartz/dartz.dart';
import '../entity/user_main_profile_info.dart';
import '../repository/main_profile_repository.dart';

class GetUserMainProfileInfoUseCase {
  final MainProfileRepository repository;

  GetUserMainProfileInfoUseCase(this.repository);

  Future<Either<Exception, UserMainProfileInfo>> call(String userId) {
    return repository.getUserMainProfileInfo(userId);
  }
}
