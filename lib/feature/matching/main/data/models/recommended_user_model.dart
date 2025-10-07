import '../../domain/entities/recommended_user.dart';
import '../../../filter/domain/entities/dating_filter.dart'; // For SmokingStatus and DrinkingStatus
import 'package:flutter/foundation.dart'; // For debugPrint

class RecommendedUserModel extends RecommendedUser {
  const RecommendedUserModel({
    required int userId,
    required String nickname,
    String? profileImageUrl,
    required int age,
    required double distanceInKm,
    required double height,
    SmokingStatus? smokingStatus,
    DrinkingStatus? drinkingStatus,
    String? location,
    String? bio,
    List<String> interests = const [],
    bool isOnline = false,
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
          bio: bio,
          interests: interests,
          isOnline: isOnline,
        );

  factory RecommendedUserModel.fromJson(Map<String, dynamic> json) {
    debugPrint('[RecommendedUserModel] Parsing JSON for user: $json');
    try {
      return RecommendedUserModel(
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
        location: json['location'] as String?,
        bio: json['bio'] as String?,
        interests: json['interests'] != null
            ? List<String>.from(json['interests'])
            : [],
        isOnline: json['isOnline'] ?? false,
      );
    } catch (e) {
      debugPrint('[RecommendedUserModel] Error parsing user JSON: $e, JSON: $json');
      rethrow; // Re-throw to see the original error in the console
    }
  }

  @override
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
      'location': location,
      'bio': bio,
      'interests': interests,
      'isOnline': isOnline,
    };
  }

  factory RecommendedUserModel.fromEntity(RecommendedUser entity) {
    return RecommendedUserModel(
      userId: entity.userId,
      nickname: entity.nickname,
      profileImageUrl: entity.profileImageUrl,
      age: entity.age,
      distanceInKm: entity.distanceInKm,
      height: entity.height,
      smokingStatus: entity.smokingStatus,
      drinkingStatus: entity.drinkingStatus,
      location: entity.location,
      bio: entity.bio,
      interests: entity.interests,
      isOnline: entity.isOnline,
    );
  }
}