import '../../domain/entities/dating_filter.dart';
import '../../domain/entities/filtered_user.dart';
import '../../domain/repositories/filter_repository.dart';
import '../datasources/filter_remote_datasource.dart';
import '../datasources/filter_local_datasource.dart';
import '../models/dating_filter_model.dart';

class FilterRepositoryImpl implements FilterRepository {
  final FilterRemoteDataSource remoteDataSource;
  final FilterLocalDataSource localDataSource;

  FilterRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<FilteredUser>> getFilteredUsers(DatingFilter filter) async {
    final filterModel = DatingFilterModel.fromEntity(filter);
    return await remoteDataSource.getFilteredUsers(filterModel);
  }

  @override
  Future<DatingFilter> saveFilter(DatingFilter filter) async {
    final filterModel = DatingFilterModel.fromEntity(filter);
    return await localDataSource.saveFilter(filterModel);
  }

  @override
  Future<DatingFilter?> getSavedFilter() async {
    return await localDataSource.getSavedFilter();
  }

  @override
  Future<void> clearSavedFilter() async {
    await localDataSource.clearSavedFilter();
  }
}