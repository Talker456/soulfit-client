import '../../domain/entities/dating_filter.dart';

class DatingFilterModel extends DatingFilter {
  const DatingFilterModel({
    required String location,
    required double minHeight,
    required double maxHeight,
    required double distance,
    required int minAge,
    required int maxAge,
    SmokingType? smokingPreference,
    DrinkingType? drinkingPreference,
  }) : super(
          location: location,
          minHeight: minHeight,
          maxHeight: maxHeight,
          distance: distance,
          minAge: minAge,
          maxAge: maxAge,
          smokingPreference: smokingPreference,
          drinkingPreference: drinkingPreference,
        );

  DatingFilterModel copyWith({
    String? location,
    double? minHeight,
    double? maxHeight,
    double? distance,
    int? minAge,
    int? maxAge,
    SmokingType? smokingPreference,
    DrinkingType? drinkingPreference,
  }) {
    return DatingFilterModel(
      location: location ?? this.location,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      distance: distance ?? this.distance,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      smokingPreference: smokingPreference ?? this.smokingPreference,
      drinkingPreference: drinkingPreference ?? this.drinkingPreference,
    );
  }

  factory DatingFilterModel.fromJson(Map<String, dynamic> json) {
    return DatingFilterModel(
      location: json['location'] ?? '한국',
      minHeight: (json['minHeight'] ?? 160).toDouble(),
      maxHeight: (json['maxHeight'] ?? 180).toDouble(),
      distance: (json['distance'] ?? 40).toDouble(),
      minAge: json['minAge'] ?? 20,
      maxAge: json['maxAge'] ?? 30,
      smokingPreference: json['smokingPreference'] != null
          ? SmokingType.values[json['smokingPreference']]
          : null,
      drinkingPreference: json['drinkingPreference'] != null
          ? DrinkingType.values[json['drinkingPreference']]
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'minHeight': minHeight,
      'maxHeight': maxHeight,
      'distance': distance,
      'minAge': minAge,
      'maxAge': maxAge,
      'smokingPreference': smokingPreference?.index,
      'drinkingPreference': drinkingPreference?.index,
    };
  }

  factory DatingFilterModel.fromEntity(DatingFilter entity) {
    return DatingFilterModel(
      location: entity.location,
      minHeight: entity.minHeight,
      maxHeight: entity.maxHeight,
      distance: entity.distance,
      minAge: entity.minAge,
      maxAge: entity.maxAge,
      smokingPreference: entity.smokingPreference,
      drinkingPreference: entity.drinkingPreference,
    );
  }
}