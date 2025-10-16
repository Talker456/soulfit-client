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
}