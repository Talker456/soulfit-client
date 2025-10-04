import 'dating_filter.dart';

class FilteredUser {
  final String id;
  final String name;
  final int age;
  final double height;
  final String location;
  final String? profileImageUrl;
  final SmokingType? smokingType;
  final DrinkingType? drinkingType;
  final double distance;

  const FilteredUser({
    required this.id,
    required this.name,
    required this.age,
    required this.height,
    required this.location,
    this.profileImageUrl,
    this.smokingType,
    this.drinkingType,
    required this.distance,
  });

  FilteredUser copyWith({
    String? id,
    String? name,
    int? age,
    double? height,
    String? location,
    String? profileImageUrl,
    SmokingType? smokingType,
    DrinkingType? drinkingType,
    double? distance,
  }) {
    return FilteredUser(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      height: height ?? this.height,
      location: location ?? this.location,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      smokingType: smokingType ?? this.smokingType,
      drinkingType: drinkingType ?? this.drinkingType,
      distance: distance ?? this.distance,
    );
  }
}