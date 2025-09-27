import '../models/dating_filter_model.dart';

abstract class FilterLocalDataSource {
  Future<DatingFilterModel> saveFilter(DatingFilterModel filter);
  Future<DatingFilterModel?> getSavedFilter();
  Future<void> clearSavedFilter();
}