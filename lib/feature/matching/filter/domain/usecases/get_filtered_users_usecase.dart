import '../entities/dating_filter.dart';
import '../entities/filtered_user.dart';
import '../repositories/filter_repository.dart';

class GetFilteredUsersUseCase {
  final FilterRepository repository;

  GetFilteredUsersUseCase(this.repository);

  Future<List<FilteredUser>> call(DatingFilter filter) async {
    return await repository.getFilteredUsers(filter);
  }
}