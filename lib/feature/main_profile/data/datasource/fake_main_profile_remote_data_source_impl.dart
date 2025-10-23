import 'dart:async';

import 'package:soulfit_client/feature/main_profile/data/model/user_album_photo_dto.dart';

import 'main_profile_remote_datasource.dart';
import '../model/user_main_profile_info_dto.dart';
import '../model/user_value_analysis_dto.dart';
import '../model/value_chart_dto.dart';

class FakeMainProfileRemoteDataSourceImpl implements MainProfileRemoteDataSource {
  @override
  Future<UserMainProfileInfoDto> fetchUserMainProfileInfo(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
    return UserMainProfileInfoDto(
      id: int.tryParse(userId) ?? 0,
      nickname: "페이크유저",
      birthDate: "1995-08-12",
      gender: "FEMALE",
      mbti: "ISFP",
      profileImageUrl: "https://picsum.photos/seed/$userId/400/400",
      introduction: "안녕하세요, 저는 페이크 유저입니다. 테스트를 위해 존재합니다.",
      personalityKeywords: ["내향적", "감성적", "계획적"],
      selfKeywords: ["진지함", "배려", "호기심"],
    );
  }

  @override
  Future<List<String>> fetchPerceivedByOthersKeywords(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ["따뜻함", "신뢰감", "조용함"];
  }

  @override
  Future<List<String>> fetchAIPredictedKeywords(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return ["이타적", "성실함", "안정지향"];
  }

  @override
  Future<UserValueAnalysisDto> fetchUserValueAnalysis(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final chartA = [
      ValueChartDto(label: "자기표현", score: 0.7),
      ValueChartDto(label: "공감", score: 0.9),
    ];

    final chartB = [
      ValueChartDto(label: "성취", score: 0.8),
      ValueChartDto(label: "안정", score: 0.6),
    ];

    return UserValueAnalysisDto(
      summary: "AI는 당신이 조화로운 인간관계를 추구한다고 분석했어요.",
      chartA: chartA,
      chartB: chartB,
    );
  }

  @override
  Future<List<UserAlbumPhotoDto>> fetchUserAlbumImages(String userId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    return [
      UserAlbumPhotoDto(id: 1, imageUrl: "https://picsum.photos/seed/${userId}1/400/400"),
      UserAlbumPhotoDto(id: 2, imageUrl: "https://picsum.photos/seed/${userId}2/400/400"),
      UserAlbumPhotoDto(id: 3, imageUrl: "https://picsum.photos/seed/${userId}3/400/400"),
    ];
  }

  @override
  Future<bool> fetchCanViewDetailedValueAnalysis({
    required String viewerUserId,
    required String targetUserId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return true; // Always allow for testing
  }
}
