import '../models/like_user_model.dart';

class CheckLikeRemoteDataSourceMock {
  Future<List<LikeUserModel>> fetchUsersWhoLikeMe(List<String> filters) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockUsers(prefix: 'LM', count: 8);
  }

  Future<List<LikeUserModel>> fetchUsersILike(
    List<String> filters, {
    String sub = 'viewed',
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return sub == 'mutual'
        ? _mockUsers(prefix: 'MU', count: 6)
        : _mockUsers(prefix: 'VW', count: 7);
  }

  List<LikeUserModel> _mockUsers({required String prefix, required int count}) {
    return List.generate(count, (i) {
      return LikeUserModel(
        id: '$prefix-$i',
        name: 'User $i',
        avatarUrl: 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
        tags: const ['다정한', '활발한', '신중한'],
      );
    });
  }
}
