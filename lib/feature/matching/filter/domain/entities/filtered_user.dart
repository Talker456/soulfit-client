import 'package:soulfit_client/feature/matching/filter/domain/entities/dating_filter.dart';

class FilteredUser {
  final int userId;
  final String nickname;
  final String? profileImageUrl;
  final int age;
  final double distanceInKm;
  final double height;
  final SmokingStatus? smokingStatus;
  final DrinkingStatus? drinkingStatus;
  final String? location; // Made nullable as it's not in API response

  const FilteredUser({
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.age,
    required this.distanceInKm,
    required this.height,
    this.smokingStatus,
    this.drinkingStatus,
    this.location,
  });

  FilteredUser copyWith({
    int? userId,
    String? nickname,
    String? profileImageUrl,
    int? age,
    double? distanceInKm,
    double? height,
    SmokingStatus? smokingStatus,
    DrinkingStatus? drinkingStatus,
    String? location,
  }) {
    return FilteredUser(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      age: age ?? this.age,
      distanceInKm: distanceInKm ?? this.distanceInKm,
      height: height ?? this.height,
      smokingStatus: smokingStatus ?? this.smokingStatus,
      drinkingStatus: drinkingStatus ?? this.drinkingStatus,
      location: location ?? this.location,
    );
  }
}
