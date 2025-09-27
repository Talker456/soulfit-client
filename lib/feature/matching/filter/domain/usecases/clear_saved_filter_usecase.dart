import '../repositories/filter_repository.dart';

class ClearSavedFilterUseCase {
  final FilterRepository repository;

  ClearSavedFilterUseCase(this.repository);

  Future<void> call() async {
    await repository.clearSavedFilter();
  }
}