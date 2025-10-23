import 'package:soulfit_client/feature/dating_profile/domain/entity/dating_profile.dart';

class DatingProfileModel {
  final String nickname;
  final int age;
  final String mbti;
  final List<String> personalityTags;
  final String introduction;
  final List<String> idealKeywords;
  final String job;
  final String heightBody;
  final String religion;
  final String smokingDrinking;
  final String loveValues;
  final String imageUrl;

  DatingProfileModel({
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

  factory DatingProfileModel.fromJson(Map<String, dynamic> j) {
    String formatSmokingDrinking(String? smoking, String? drinking) {
      final smokeStatus = smoking == 'NON_SMOKER' ? '비흡연' : (smoking ?? '정보 없음');
      final drinkStatus = drinking == 'SOMETIMES' ? '가끔 음주' : (drinking ?? '정보 없음');
      return '$smokeStatus, $drinkStatus';
    }

    return DatingProfileModel(
      nickname: j['username'] ?? '이름 없음',
      age: j['age'] ?? 0,
      mbti: j['mbti'] ?? 'XXXX',
      personalityTags: List<String>.from(j['personalityKeywords'] ?? []),
      introduction: j['bio'] ?? '자기소개가 없습니다.',
      idealKeywords: List<String>.from(j['idealTypes'] ?? []),
      job: j['job'] ?? '직업 정보 없음',
      heightBody: (j['heightCm'] != null && j['weightKg'] != null)
          ? "${j['heightCm']}cm, ${j['weightKg']}kg"
          : "키/몸무게 정보 없음",
      religion: j['religion'] ?? '정보 없음',
      smokingDrinking: formatSmokingDrinking(j['smoking'], j['drinking']),
      loveValues: j['loveValues'] ?? "가치관 정보가 없습니다.", // Placeholder
      imageUrl: j['profileImageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'nickname': nickname,
    'age': age,
    'mbti': mbti,
    'personalityTags': personalityTags,
    'introduction': introduction,
    'idealKeywords': idealKeywords,
    'job': job,
    'heightBody': heightBody,
    'religion': religion,
    'smokingDrinking': smokingDrinking,
    'loveValues': loveValues,
    'imageUrl': imageUrl,
  };

  DatingProfile toEntity() => DatingProfile(
    nickname: nickname,
    age: age,
    mbti: mbti,
    personalityTags: personalityTags,
    introduction: introduction,
    idealKeywords: idealKeywords,
    job: job,
    heightBody: heightBody,
    religion: religion,
    smokingDrinking: smokingDrinking,
    loveValues: loveValues,
    imageUrl: imageUrl,
  );
}
