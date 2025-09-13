class DatingProfile {
  final String nickname;
  final int age;
  final String mbti;
  final List<String> personalityTags; // "섬세함", "다정함" 등
  final String introduction;
  final List<String> idealKeywords; // "귀여운", "다정함" 등
  final String job;
  final String heightBody; // "180cm, 조금 통통"
  final String religion; // "무교"
  final String smokingDrinking; // "흡연자, 가끔 마셔요"
  final String loveValues; // 하단 연애가치관 문단
  final String imageUrl; // 프로필 이미지

  DatingProfile({
    required this.nickname,
    required this.age,
    required this.mbti,
    required this.personalityTags,
    required this.introduction,
    required this.idealKeywords,
    required this.job,
    required this.heightBody,
    required this.religion,
    required this.smokingDrinking,
    required this.loveValues,
    required this.imageUrl,
  });
}
