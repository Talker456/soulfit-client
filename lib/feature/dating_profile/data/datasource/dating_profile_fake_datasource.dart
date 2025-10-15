import 'dart:developer' as dev;
import 'package:soulfit_client/feature/dating_profile/data/model/dating_profile_model.dart';

abstract class DatingProfileDataSource {
  Future<DatingProfileModel> getProfile(
      {required String viewerUserId, required String targetUserId});
}

class DatingProfileFakeDataSource implements DatingProfileDataSource {
  @override
  Future<DatingProfileModel> getProfile(
      {required String viewerUserId, required String targetUserId}) async {
    dev.log('[FakeDS] getProfile(viewer: $viewerUserId, target: $targetUserId) called',
        name: 'DatingProfileFakeDS');
    await Future<void>.delayed(const Duration(milliseconds: 300));
    dev.log('[FakeDS] returning model', name: 'DatingProfileFakeDS');

    return DatingProfileModel.fromJson({
      "nickname": "닉네임",
      "age": 29,
      "mbti": "ENTJ",
      "personalityTags": ["섬세함", "다정함", "듬직함"],
      "introduction":
          "안녕하세요! 저는 감정 표현 솔직한 편이고 취미는 드라마봐요! 가볍게 시작해도, 깊이 있게 이어가는 관계를 지향해요.",
      "idealKeywords": ["귀여운", "다정함", "활발함"],
      "job": "사업가",
      "heightBody": "180cm, 조금 통통",
      "religion": "무교",
      "smokingDrinking": "흡연자, 가끔 마셔요",
      "loveValues":
          "감정의 진정성과 깊이 있는 연결을 중요하게 생각하며, 갈등이 생겨도 대화를 통해 해결하려는 성숙한 태도를 지녔습니다. 상대방과의 가치관 일치를 중시하고, 서로에 대한 존중이 바탕이 되는 관계를 선호합니다. 애정 표현에는 신중한 편이지만 신뢰가 쌓이면 진심 어린 애정을 보여주는 스타일입니다. 관계 안에서 함께 성장하고, 파트너로서 서로를 지지하는 연애를 지향합니다. 전반적으로 안정감 있고 깊이 있는 관계를 추구하는 성향입니다.",
      "imageUrl":
          "https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=1200&auto=format&fit=crop",
    });
  }
}
