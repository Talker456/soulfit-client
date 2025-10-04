class DatingFilter {
  final String location;
  final double minHeight;
  final double maxHeight;
  final double distance;
  final int minAge;
  final int maxAge;
  final SmokingType? smokingPreference;
  final DrinkingType? drinkingPreference;

  const DatingFilter({
    required this.location,
    required this.minHeight,
    required this.maxHeight,
    required this.distance,
    required this.minAge,
    required this.maxAge,
    this.smokingPreference,
    this.drinkingPreference,
  });

  DatingFilter copyWith({
    String? location,
    double? minHeight,
    double? maxHeight,
    double? distance,
    int? minAge,
    int? maxAge,
    SmokingType? smokingPreference,
    DrinkingType? drinkingPreference,
  }) {
    return DatingFilter(
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

  // 기본 필터값
  static const DatingFilter defaultFilter = DatingFilter(
    location: '한국',
    minHeight: 160,
    maxHeight: 180,
    distance: 40,
    minAge: 20,
    maxAge: 30,
    smokingPreference: null,
    drinkingPreference: null,
  );
}

enum SmokingType {
  smoker('흡연자'),
  nonSmoker('비흡연자');

  const SmokingType(this.displayName);
  final String displayName;
}

enum DrinkingType {
  often('자주 마셔요'),
  sometimes('종종 마셔요'),
  never('안 마셔요');

  const DrinkingType(this.displayName);
  final String displayName;
}