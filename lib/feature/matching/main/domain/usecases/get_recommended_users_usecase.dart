import '../entities/recommended_user.dart';
import '../repositories/dating_main_repository.dart';

class GetRecommendedUsersUseCase {
  final DatingMainRepository repository;

  GetRecommendedUsersUseCase(this.repository);

  Future<List<RecommendedUser>> call({int limit = 10}) async {
    return await repository.getRecommendedUsers(limit: limit);
  }
}