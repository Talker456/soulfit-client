import '../../domain/entities/recommended_user.dart';
import '../../domain/entities/first_impression_vote.dart';
import '../../../filter/domain/entities/dating_filter.dart'; // Import DatingFilter
import '../models/recommended_user_model.dart';
import '../models/first_impression_vote_model.dart';
import 'dating_main_remote_datasource.dart';

class DatingMainFakeDataSource implements DatingMainRemoteDataSource {
  final List<RecommendedUserModel> _allUsers = [
    RecommendedUserModel(
      userId: 1,
      nickname: '김예원',
      age: 25,
      distanceInKm: 1.2,
      profileImageUrl: 'https://picsum.photos/400/400?random=1',
      bio: '안녕하세요! 카페 투어와 독서를 좋아합니다.',
      interests: ['카페', '독서', '요가'],
      isOnline: true,
      height: 165,
      location: '서울시 강남구',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.SOMETIMES,
    ),
    RecommendedUserModel(
      userId: 2,
      nickname: '이민지',
      age: 23,
      distanceInKm: 2.1,
      profileImageUrl: 'https://picsum.photos/400/400?random=2',
      bio: '여행과 사진 찍기를 좋아해요!',
      interests: ['여행', '사진', '맛집탐방'],
      isOnline: false,
      height: 162,
      location: '서울시 홍대',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.NEVER,
    ),
    RecommendedUserModel(
      userId: 3,
      nickname: '박서연',
      age: 27,
      distanceInKm: 0.8,
      profileImageUrl: 'https://picsum.photos/400/400?random=3',
      bio: '영화와 음악을 사랑하는 사람입니다.',
      interests: ['영화', '음악', '콘서트'],
      isOnline: true,
      height: 180,
      location: '경기도 수원시',
      smokingStatus: SmokingStatus.OCCASIONAL,
      drinkingStatus: DrinkingStatus.DAILY,
    ),
    RecommendedUserModel(
      userId: 4,
      nickname: '최유진',
      age: 24,
      distanceInKm: 3.5,
      profileImageUrl: 'https://picsum.photos/400/400?random=4',
      bio: '운동과 건강한 라이프스타일을 추구해요.',
      interests: ['헬스', '요가', '등산'],
      isOnline: false,
      height: 168,
      location: '서울시 잠실',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.SOMETIMES,
    ),
    RecommendedUserModel(
      userId: 5,
      nickname: '정도현',
      age: 30,
      distanceInKm: 1.9,
      profileImageUrl: 'https://picsum.photos/400/400?random=5',
      bio: '요리하고 맛있는 것 먹는 걸 좋아합니다.',
      interests: ['요리', '베이킹', '와인'],
      isOnline: true,
      height: 178,
      location: '인천시',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.DAILY,
    ),
  ];

  @override
  Future<List<RecommendedUserModel>> getRecommendedUsers(DatingFilter filter, {int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    List<RecommendedUserModel> filteredUsers = _allUsers.where((user) {
      // 나이 필터링
      if (user.age < filter.minAge || user.age > filter.maxAge) {
        return false;
      }

      // 거리 필터링
      if (user.distanceInKm > filter.maxDistanceInKm) {
        return false;
      }

      // 흡연 필터링
      if (filter.smokingStatus != null && user.smokingStatus != filter.smokingStatus) {
        return false;
      }

      // 음주 필터링
      if (filter.drinkingStatus != null && user.drinkingStatus != filter.drinkingStatus) {
        return false;
      }

      // 지역 필터링 (간단하게 포함 여부로 체크)
      // user.location이 nullable이므로 null 체크 추가
      if (user.location != null && !user.location!.contains(filter.region) && filter.region != 'Seoul') {
        return false;
      }

      // currentUserLatitude, currentUserLongitude는 현재 Fake에서는 사용하지 않음

      return true;
    }).toList();

    // 거리순으로 정렬
    filteredUsers.sort((a, b) => a.distanceInKm.compareTo(b.distanceInKm));

    return filteredUsers.take(limit).toList();
  }

  @override
  Future<FirstImpressionVoteModel?> getLatestFirstImpressionVote() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Updated to match the new FirstImpressionVoteModel structure
    return FirstImpressionVoteModel(
      id: 101, // Changed to int
      creatorId: 2, // Changed from userId to creatorId, and to int
      creatorUsername: '이민지', // Changed from userName to creatorUsername
      title: '주말에 같이 운동 어때요?', // Changed from message to title
      creatorProfileImageUrl: 'https://picsum.photos/400/400?random=2', // Changed field name
      isRead: false,
    );
  }

  @override
  Future<void> markFirstImpressionVoteAsRead(String voteId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
