import '../../../filter/domain/entities/dating_filter.dart';
import '../entities/recommended_user.dart';
import '../repositories/dating_main_repository.dart';

class GetRecommendedUsersUseCase {
  final DatingMainRepository repository;

  GetRecommendedUsersUseCase(this.repository);

  Future<List<RecommendedUser>> call(DatingFilter filter, {int limit = 10}) async {
    return await repository.getRecommendedUsers(filter, limit: limit);
  }
}