import '../../domain/entity/user_main_profile_info.dart';

class UserMainProfileInfoDto {
  final int id;
  final String nickname;
  final String birthDate;
  final String gender;
  final String mbti;
  final String profileImageUrl;
  final String introduction;
  final List<String> personalityKeywords;
  final List<String> selfKeywords;

  UserMainProfileInfoDto({
    required this.id,
    required this.nickname,
    required this.birthDate,
    required this.gender,
    required this.mbti,
    required this.profileImageUrl,
    required this.introduction,
    required this.personalityKeywords,
    required this.selfKeywords,
  });

  factory UserMainProfileInfoDto.fromJson(Map<String, dynamic> json) {
    return UserMainProfileInfoDto(
      id: json['id'],
      nickname: json['nickname'],
      birthDate: json['birthDate'],
      gender: json['gender'],
      mbti: json['mbti'],
      profileImageUrl: json['profileImageUrl'],
      introduction: json['bio'], // API spec uses 'bio'
      personalityKeywords: List<String>.from(json['personalityKeywords']),
      // 'selfKeywords' is not in the spec, handle potential null
      selfKeywords: json['selfKeywords'] != null ? List<String>.from(json['selfKeywords']) : [],
    );
  }

  UserMainProfileInfo toEntity() {
    return UserMainProfileInfo(
      id: id,
      nickname: nickname,
      birthDate: birthDate,
      gender: gender,
      mbti: mbti,
      profileImageUrl: profileImageUrl,
      introduction: introduction,
      personalityKeywords: personalityKeywords,
      selfKeywords: selfKeywords,
    );
  }
}
