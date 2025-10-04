import '../entities/dating_filter.dart';
import '../entities/filtered_user.dart';

abstract class FilterRepository {
  Future<List<FilteredUser>> getFilteredUsers(DatingFilter filter);
  Future<DatingFilter> saveFilter(DatingFilter filter);
  Future<DatingFilter?> getSavedFilter();
  Future<void> clearSavedFilter();
}