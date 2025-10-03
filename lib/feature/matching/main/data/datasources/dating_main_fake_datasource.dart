import '../models/recommended_user_model.dart';
import '../models/first_impression_vote_model.dart';
import 'dating_main_remote_datasource.dart';

class DatingMainFakeDataSource implements DatingMainRemoteDataSource {
  @override
  Future<List<RecommendedUserModel>> getRecommendedUsers({int limit = 10}) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final fakeUsers = [
      const RecommendedUserModel(
        id: '1',
        name: '김예원',
        age: 25,
        distance: 1.2,
        profileImageUrl: 'https://picsum.photos/400/400?random=1',
        bio: '안녕하세요! 카페 투어와 독서를 좋아합니다.',
        interests: ['카페', '독서', '요가'],
        isOnline: true,
      ),
      const RecommendedUserModel(
        id: '2',
        name: '이민지',
        age: 23,
        distance: 2.1,
        profileImageUrl: 'https://picsum.photos/400/400?random=2',
        bio: '여행과 사진 찍기를 좋아해요!',
        interests: ['여행', '사진', '맛집탐방'],
        isOnline: false,
      ),
      const RecommendedUserModel(
        id: '3',
        name: '박서연',
        age: 27,
        distance: 0.8,
        profileImageUrl: 'https://picsum.photos/400/400?random=3',
        bio: '영화와 음악을 사랑하는 사람입니다.',
        interests: ['영화', '음악', '콘서트'],
        isOnline: true,
      ),
      const RecommendedUserModel(
        id: '4',
        name: '최유진',
        age: 24,
        distance: 3.5,
        profileImageUrl: 'https://picsum.photos/400/400?random=4',
        bio: '운동과 건강한 라이프스타일을 추구해요.',
        interests: ['헬스', '요가', '등산'],
        isOnline: false,
      ),
      const RecommendedUserModel(
        id: '5',
        name: '정하영',
        age: 26,
        distance: 1.9,
        profileImageUrl: 'https://picsum.photos/400/400?random=5',
        bio: '요리하고 맛있는 것 먹는 걸 좋아합니다.',
        interests: ['요리', '베이킹', '와인'],
        isOnline: true,
      ),
    ];

    return fakeUsers.take(limit).toList();
  }

  @override
  Future<FirstImpressionVoteModel?> getLatestFirstImpressionVote() async {
    await Future.delayed(const Duration(milliseconds: 300));

    // Updated to match the new FirstImpressionVoteModel structure
    return const FirstImpressionVoteModel(
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