import '../models/dating_filter_model.dart';
import '../models/filtered_user_model.dart';

abstract class FilterRemoteDataSource {
  Future<List<FilteredUserModel>> getFilteredUsers(DatingFilterModel filter);
}