import '../../domain/entity/user_main_profile_info.dart';

class UserMainProfileInfoDto {
  final String profileImageUrl;
  final String introduction;
  final List<String> personalityKeywords;
  final List<String> selfKeywords;

  UserMainProfileInfoDto({
    required this.profileImageUrl,
    required this.introduction,
    required this.personalityKeywords,
    required this.selfKeywords,
  });

  factory UserMainProfileInfoDto.fromJson(Map<String, dynamic> json) {
    return UserMainProfileInfoDto(
      profileImageUrl: json['profileImageUrl'],
      introduction: json['introduction'],
      personalityKeywords: List<String>.from(json['personalityKeywords']),
      selfKeywords: List<String>.from(json['selfKeywords']),
    );
  }

  UserMainProfileInfo toEntity() {
    return UserMainProfileInfo(
      profileImageUrl: profileImageUrl,
      introduction: introduction,
      personalityKeywords: personalityKeywords,
      selfKeywords: selfKeywords,
    );
  }
}
