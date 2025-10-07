import '../../domain/entities/dating_filter.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

class DatingFilterModel extends DatingFilter {
  const DatingFilterModel({
    required double currentUserLatitude,
    required double currentUserLongitude,
    required String region,
    required int minAge,
    required int maxAge,
    required int maxDistanceInKm,
    SmokingStatus? smokingStatus,
    DrinkingStatus? drinkingStatus,
  }) : super(
          currentUserLatitude: currentUserLatitude,
          currentUserLongitude: currentUserLongitude,
          region: region,
          minAge: minAge,
          maxAge: maxAge,
          maxDistanceInKm: maxDistanceInKm,
          smokingStatus: smokingStatus,
          drinkingStatus: drinkingStatus,
        );

  // fromJson factory to create a model from a local storage map
  factory DatingFilterModel.fromJson(Map<String, dynamic> json) {
    return DatingFilterModel(
      currentUserLatitude: (json['currentUserLatitude'] ?? 37.5665).toDouble(),
      currentUserLongitude: (json['currentUserLongitude'] ?? 126.9780).toDouble(),
      region: json['region'] ?? '',
      minAge: json['minAge'] ?? 20,
      maxAge: json['maxAge'] ?? 30,
      maxDistanceInKm: json['maxDistanceInKm'] ?? 10,
      smokingStatus: json['smokingStatus'] != null
          ? SmokingStatus.values.byName(json['smokingStatus'])
          : null,
      drinkingStatus: json['drinkingStatus'] != null
          ? DrinkingStatus.values.byName(json['drinkingStatus'])
          : null,
    );
  }

  // toJson method to save the model to local storage
  Map<String, dynamic> toJson() {
    return {
      'currentUserLatitude': currentUserLatitude,
      'currentUserLongitude': currentUserLongitude,
      'region': region,
      'minAge': minAge,
      'maxAge': maxAge,
      'maxDistanceInKm': maxDistanceInKm,
      'smokingStatus': smokingStatus?.name,
      'drinkingStatus': drinkingStatus?.name,
    };
  }

  factory DatingFilterModel.fromEntity(DatingFilter entity) {
    return DatingFilterModel(
      currentUserLatitude: entity.currentUserLatitude,
      currentUserLongitude: entity.currentUserLongitude,
      region: entity.region,
      minAge: entity.minAge,
      maxAge: entity.maxAge,
      maxDistanceInKm: entity.maxDistanceInKm,
      smokingStatus: entity.smokingStatus,
      drinkingStatus: entity.drinkingStatus,
    );
  }

  // Method to convert the model to query parameters for the API call
  Map<String, String> toQueryParameters() {
    final Map<String, dynamic> map = {
      'currentUserLatitude': currentUserLatitude.toString(),
      'currentUserLongitude': currentUserLongitude.toString(),
      'region': region,
      'minAge': minAge.toString(),
      'maxAge': maxAge.toString(),
      'maxDistanceInKm': maxDistanceInKm.toString(),
      'smokingStatus': smokingStatus?.name,
      'drinkingStatus': drinkingStatus?.name,
      // 'size': '20', // Pagination can be added here if needed
      // 'page': '0',
    };

    // Remove null values so they are not included in the query string
    map.removeWhere((key, value) => value == null);

    // Ensure all values are strings
    final queryParams = map.map((key, value) => MapEntry(key, value.toString()));
    debugPrint('[DatingFilterModel] Generated Query Parameters: $queryParams');
    return queryParams;
  }
}