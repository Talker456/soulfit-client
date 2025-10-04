import '../entities/dating_filter.dart';
import '../repositories/filter_repository.dart';

class GetSavedFilterUseCase {
  final FilterRepository repository;

  GetSavedFilterUseCase(this.repository);

  Future<DatingFilter?> call() async {
    return await repository.getSavedFilter();
  }
}