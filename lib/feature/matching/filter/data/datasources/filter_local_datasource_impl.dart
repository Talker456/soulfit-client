import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/dating_filter_model.dart';
import 'filter_local_datasource.dart';

class FilterLocalDataSourceImpl implements FilterLocalDataSource {
  final FlutterSecureStorage storage;
  static const String _filterKey = 'dating_filter';

  FilterLocalDataSourceImpl({required this.storage});

  @override
  Future<DatingFilterModel> saveFilter(DatingFilterModel filter) async {
    final jsonString = jsonEncode(filter.toJson());
    await storage.write(key: _filterKey, value: jsonString);
    return filter;
  }

  @override
  Future<DatingFilterModel?> getSavedFilter() async {
    try {
      final jsonString = await storage.read(key: _filterKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString);
        return DatingFilterModel.fromJson(json);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearSavedFilter() async {
    await storage.delete(key: _filterKey);
  }
}