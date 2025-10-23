import '../../../filter/domain/entities/dating_filter.dart';
import '../../../filter/domain/entities/filtered_user.dart';

class RecommendedUser extends FilteredUser {
  final String? bio;
  final List<String> interests;
  final bool isOnline;

  const RecommendedUser({
    required int userId,
    required String nickname,
    String? profileImageUrl,
    required int age,
    required double distanceInKm,
    required double height,
    SmokingStatus? smokingStatus,
    DrinkingStatus? drinkingStatus,
    String? location,
    this.bio,
    this.interests = const [],
    this.isOnline = false,
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

  @override
  RecommendedUser copyWith({
    int? userId,
    String? nickname,
    String? profileImageUrl,
    int? age,
    double? distanceInKm,
    double? height,
    SmokingStatus? smokingStatus,
    DrinkingStatus? drinkingStatus,
    String? location,
    String? bio,
    List<String>? interests,
    bool? isOnline,
  }) {
    return RecommendedUser(
      userId: userId ?? this.userId,
      nickname: nickname ?? this.nickname,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      age: age ?? this.age,
      distanceInKm: distanceInKm ?? this.distanceInKm,
      height: height ?? this.height,
      smokingStatus: smokingStatus ?? this.smokingStatus,
      drinkingStatus: drinkingStatus ?? this.drinkingStatus,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}