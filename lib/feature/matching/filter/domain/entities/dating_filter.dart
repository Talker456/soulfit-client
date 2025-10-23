enum SmokingStatus {
  NON_SMOKER,
  OCCASIONAL,
  REGULAR,
}

enum DrinkingStatus {
  NEVER,
  SOMETIMES,
  OFTEN,
  DAILY,
}

class DatingFilter {
  final double currentUserLatitude;
  final double currentUserLongitude;
  final String region;
  final int minAge;
  final int maxAge;
  final int? minHeight;
  final int? maxHeight;
  final int maxDistanceInKm;
  final SmokingStatus? smokingStatus;
  final DrinkingStatus? drinkingStatus;

  const DatingFilter({
    required this.currentUserLatitude,
    required this.currentUserLongitude,
    required this.region,
    required this.minAge,
    required this.maxAge,
    this.minHeight,
    this.maxHeight,
    required this.maxDistanceInKm,
    this.smokingStatus,
    this.drinkingStatus,
  });

  DatingFilter copyWith({
    double? currentUserLatitude,
    double? currentUserLongitude,
    String? region,
    int? minAge,
    int? maxAge,
    int? minHeight,
    int? maxHeight,
    int? maxDistanceInKm,
    Object? smokingStatus = _undefined,  // ← Object 타입 사용!
    Object? drinkingStatus = _undefined,
  }) {
    return DatingFilter(
      currentUserLatitude: currentUserLatitude ?? this.currentUserLatitude,
      currentUserLongitude: currentUserLongitude ?? this.currentUserLongitude,
      region: region ?? this.region,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      maxDistanceInKm: maxDistanceInKm ?? this.maxDistanceInKm,
      smokingStatus: smokingStatus == _undefined
          ? this.smokingStatus
          : smokingStatus as SmokingStatus?,  // ← null 허용
      drinkingStatus: drinkingStatus == _undefined
          ? this.drinkingStatus
          : drinkingStatus as DrinkingStatus?,
    );
  }

  // Default filter values, assuming some defaults for lat/long
  static const DatingFilter defaultFilter = DatingFilter(
    currentUserLatitude: 37.5665, // Default to Seoul
    currentUserLongitude: 126.9780,
    region: '', // Removed default region filter
    minAge: 20,
    maxAge: 30,
    minHeight: null,
    maxHeight: null,
    maxDistanceInKm: 100, // Effectively removed distance filter
    smokingStatus: null,
    drinkingStatus: null,
  );
}

const _undefined = Object();

extension SmokingStatusExtension on SmokingStatus {
  String get displayName {
    switch (this) {
      case SmokingStatus.NON_SMOKER:
        return '비흡연';
      case SmokingStatus.OCCASIONAL:
        return '가끔';
      case SmokingStatus.REGULAR:
        return '자주';
    }
  }
}

extension DrinkingStatusExtension on DrinkingStatus {
  String get displayName {
    switch (this) {
      case DrinkingStatus.NEVER:
        return '전혀 안 함';
      case DrinkingStatus.SOMETIMES:
        return '가끔';
      case DrinkingStatus.OFTEN:
        return '자주';
      case DrinkingStatus.DAILY:
        return '매일';
    }
  }
}