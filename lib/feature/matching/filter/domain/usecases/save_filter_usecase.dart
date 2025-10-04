import '../entities/dating_filter.dart';
import '../repositories/filter_repository.dart';

class SaveFilterUseCase {
  final FilterRepository repository;

  SaveFilterUseCase(this.repository);

  Future<DatingFilter> call(DatingFilter filter) async {
    return await repository.saveFilter(filter);
  }
}