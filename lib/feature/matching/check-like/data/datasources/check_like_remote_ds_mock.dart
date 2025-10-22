import '../models/ai_match_response_model.dart';
import '../models/like_user_model.dart';
import 'check_like_remote_ds.dart';

class CheckLikeRemoteDataSourceMockImpl implements CheckLikeRemoteDataSource {
  @override
  Future<List<LikeUserModel>> fetchUsersWhoLikeMe() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockUsers(prefix: 'LM', count: 8);
  }

  @override
  Future<List<LikeUserModel>> fetchUsersILike() async {
    await Future.delayed(const Duration(milliseconds: 600));
    // Since 'sub' parameter is removed, we'll just return a generic list for now.
    return _mockUsers(prefix: 'IL', count: 7);
  }

  List<LikeUserModel> _mockUsers({required String prefix, required int count}) {
    return List.generate(count, (i) {
      return LikeUserModel(
        id: '$prefix-$i',
        name: 'User $i',
        avatarUrl: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
      );
    });
  }
    @override
    Future<List<AiMatchResponseModel>> getAiMatch(List<int> candidateUserIds) async {
      await Future.delayed(const Duration(milliseconds: 1200));
      // Return a mock response for the first candidate user, if available.
      if (candidateUserIds.isNotEmpty) {
        return [
          AiMatchResponseModel(
            userId: candidateUserIds.first,
            matchScore: 0.85,
            matchReason: '가치관이 매우 유사하여 높은 점수를 받았습니다. 특히 현실적인 문제 해결 방식과 안정성을 중시하는 면에서 잘 맞을 것으로 보입니다.',
          ),
        ];
      }
      return [];
    }
  }
  