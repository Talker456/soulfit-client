import '../../domain/entities/filtered_user.dart';
import '../../domain/entities/dating_filter.dart'; // For SmokingStatus and DrinkingStatus enums
import 'package:flutter/foundation.dart'; // For debugPrint

class FilteredUserModel extends FilteredUser {
  const FilteredUserModel({
    required int userId,
    required String nickname,
    String? profileImageUrl,
    required int age,
    required double distanceInKm,
    required double height,
    SmokingStatus? smokingStatus,
    DrinkingStatus? drinkingStatus,
    String? location,
  }) : super(
          userId: userId,
          nickname: nickname,
          profileImageUrl: profileImageUrl,
          age: age,
          distanceInKm: distanceInKm,
          height: height,
          smokingStatus: smokingStatus,
          drinkingStatus: drinkingStatus,
          location: location,
        );

  factory FilteredUserModel.fromJson(Map<String, dynamic> json) {
    debugPrint('[FilteredUserModel] Parsing JSON: $json');
    return FilteredUserModel(
      userId: json['userId'] as int,
      nickname: json['nickname'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      age: json['age'] as int,
      distanceInKm: (json['distanceInKm'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      smokingStatus: json['smokingStatus'] != null
          ? SmokingStatus.values.byName(json['smokingStatus'] as String)
          : null,
      drinkingStatus: json['drinkingStatus'] != null
          ? DrinkingStatus.values.byName(json['drinkingStatus'] as String)
          : null,
      location: null, // API response does not contain location, so set to null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'profileImageUrl': profileImageUrl,
      'age': age,
      'distanceInKm': distanceInKm,
      'height': height,
      'smokingStatus': smokingStatus?.name,
      'drinkingStatus': drinkingStatus?.name,
      // 'location': location, // Not included as it's not in API response
    };
  }

  factory FilteredUserModel.fromEntity(FilteredUser entity) {
    return FilteredUserModel(
      userId: entity.userId,
      nickname: entity.nickname,
      profileImageUrl: entity.profileImageUrl,
      age: entity.age,
      distanceInKm: entity.distanceInKm,
      height: entity.height,
      smokingStatus: entity.smokingStatus,
      drinkingStatus: entity.drinkingStatus,
      location: entity.location,
    );
  }
}