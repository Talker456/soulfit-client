import 'package:soulfit_client/feature/dating_profile/domain/entity/dating_profile.dart';
import 'package:soulfit_client/feature/dating_profile/domain/repository/dating_profile_repository.dart';
import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_fake_datasource.dart';

class DatingProfileRepositoryImpl implements DatingProfileRepository {
  final DatingProfileDataSource dataSource;
  DatingProfileRepositoryImpl(this.dataSource);

  @override
  Future<DatingProfile> getProfile(String userId) async {
    final model = await dataSource.getProfile(userId);
    return model.toEntity();
  }
}
