/// 투표 대상 유저 Entity
/// 첫인상 투표에 참여할 수 있는 유저 정보
class VoteTarget {
  final int userId;
  final String username;
  final int age;
  final String? profileImageUrl;
  final List<String> additionalImages;
  final String? bio;
  final String? location;
  final double? distance;

  const VoteTarget({
    required this.userId,
    required this.username,
    required this.age,
    this.profileImageUrl,
    this.additionalImages = const [],
    this.bio,
    this.location,
    this.distance,
  });

  VoteTarget copyWith({
    int? userId,
    String? username,
    int? age,
    String? profileImageUrl,
    List<String>? additionalImages,
    String? bio,
    String? location,
    double? distance,
  }) {
    return VoteTarget(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      age: age ?? this.age,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      additionalImages: additionalImages ?? this.additionalImages,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      distance: distance ?? this.distance,
    );
  }
}
