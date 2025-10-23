class UserMainProfileInfo {
  final int id;
  final String nickname;
  final String birthDate;
  final String gender;
  final String mbti;
  final String profileImageUrl;
  final String introduction;
  final List<String> personalityKeywords;
  final List<String> selfKeywords;

  UserMainProfileInfo({
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
}
