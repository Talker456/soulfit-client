import '../../domain/entities/filtered_user.dart';
import '../../domain/entities/dating_filter.dart';

class FilteredUserModel extends FilteredUser {
  const FilteredUserModel({
    required String id,
    required String name,
    required int age,
    required double height,
    required String location,
    String? profileImageUrl,
    SmokingType? smokingType,
    DrinkingType? drinkingType,
    required double distance,
  }) : super(
          id: id,
          name: name,
          age: age,
          height: height,
          location: location,
          profileImageUrl: profileImageUrl,
          smokingType: smokingType,
          drinkingType: drinkingType,
          distance: distance,
        );

  FilteredUserModel copyWith({
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
    return FilteredUserModel(
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

  factory FilteredUserModel.fromJson(Map<String, dynamic> json) {
    return FilteredUserModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      height: (json['height']).toDouble(),
      location: json['location'],
      profileImageUrl: json['profileImageUrl'],
      smokingType: json['smokingType'] != null
          ? SmokingType.values[json['smokingType']]
          : null,
      drinkingType: json['drinkingType'] != null
          ? DrinkingType.values[json['drinkingType']]
          : null,
      distance: (json['distance']).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'height': height,
      'location': location,
      'profileImageUrl': profileImageUrl,
      'smokingType': smokingType?.index,
      'drinkingType': drinkingType?.index,
      'distance': distance,
    };
  }

  factory FilteredUserModel.fromEntity(FilteredUser entity) {
    return FilteredUserModel(
      id: entity.id,
      name: entity.name,
      age: entity.age,
      height: entity.height,
      location: entity.location,
      profileImageUrl: entity.profileImageUrl,
      smokingType: entity.smokingType,
      drinkingType: entity.drinkingType,
      distance: entity.distance,
    );
  }
}