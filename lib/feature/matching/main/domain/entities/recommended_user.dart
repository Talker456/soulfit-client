class RecommendedUser {
  final String id;
  final String name;
  final int age;
  final double distance;
  final String profileImageUrl;
  final String? bio;
  final List<String> interests;
  final bool isOnline;

  const RecommendedUser({
    required this.id,
    required this.name,
    required this.age,
    required this.distance,
    required this.profileImageUrl,
    this.bio,
    this.interests = const [],
    this.isOnline = false,
  });

  RecommendedUser copyWith({
    String? id,
    String? name,
    int? age,
    double? distance,
    String? profileImageUrl,
    String? bio,
    List<String>? interests,
    bool? isOnline,
  }) {
    return RecommendedUser(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      distance: distance ?? this.distance,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      bio: bio ?? this.bio,
      interests: interests ?? this.interests,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}