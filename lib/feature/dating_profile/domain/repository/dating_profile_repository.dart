import 'package:soulfit_client/feature/dating_profile/domain/entity/dating_profile.dart';

abstract class DatingProfileRepository {
  Future<DatingProfile> getProfile(String userId);
}
