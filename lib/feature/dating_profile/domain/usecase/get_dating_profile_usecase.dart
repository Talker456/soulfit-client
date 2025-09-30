import 'package:soulfit_client/feature/dating_profile/domain/entity/dating_profile.dart';
import 'package:soulfit_client/feature/dating_profile/domain/repository/dating_profile_repository.dart';

class GetDatingProfileUseCase {
  final DatingProfileRepository repo;
  GetDatingProfileUseCase(this.repo);

  Future<DatingProfile> call(String userId) => repo.getProfile(userId);
}
