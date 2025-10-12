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
    return DatingProfileModel(
      nickname: j['nickname'],
      age: j['age'],
      mbti: j['mbti'],
      personalityTags: List<String>.from(j['personalityTags'] ?? []),
      introduction: j['introduction'],
      idealKeywords: List<String>.from(j['idealKeywords'] ?? []),
      job: j['job'],
      heightBody: j['heightBody'],
      religion: j['religion'],
      smokingDrinking: j['smokingDrinking'],
      loveValues: j['loveValues'],
      imageUrl: j['imageUrl'],
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
