import '../../domain/entities/filtered_user.dart';
import '../../domain/entities/dating_filter.dart';
import '../models/dating_filter_model.dart';
import '../models/filtered_user_model.dart';
import 'filter_remote_datasource.dart';

class FakeFilterRemoteDataSource implements FilterRemoteDataSource {
  final List<FilteredUserModel> _allUsers = [
    const FilteredUserModel(
      id: '1',
      name: '김민수',
      age: 25,
      height: 175,
      location: '서울시 강남구',
      profileImageUrl: 'https://example.com/profile1.jpg',
      smokingType: SmokingType.nonSmoker,
      drinkingType: DrinkingType.sometimes,
      distance: 5.2,
    ),
    const FilteredUserModel(
      id: '2',
      name: '이지현',
      age: 23,
      height: 162,
      location: '서울시 홍대',
      profileImageUrl: 'https://example.com/profile2.jpg',
      smokingType: SmokingType.nonSmoker,
      drinkingType: DrinkingType.never,
      distance: 12.8,
    ),
    const FilteredUserModel(
      id: '3',
      name: '박준혁',
      age: 28,
      height: 180,
      location: '경기도 수원시',
      profileImageUrl: 'https://example.com/profile3.jpg',
      smokingType: SmokingType.smoker,
      drinkingType: DrinkingType.often,
      distance: 25.5,
    ),
    const FilteredUserModel(
      id: '4',
      name: '최서연',
      age: 26,
      height: 165,
      location: '서울시 잠실',
      profileImageUrl: 'https://example.com/profile4.jpg',
      smokingType: SmokingType.nonSmoker,
      drinkingType: DrinkingType.sometimes,
      distance: 8.1,
    ),
    const FilteredUserModel(
      id: '5',
      name: '정도현',
      age: 30,
      height: 178,
      location: '인천시',
      profileImageUrl: 'https://example.com/profile5.jpg',
      smokingType: SmokingType.nonSmoker,
      drinkingType: DrinkingType.often,
      distance: 35.7,
    ),
  ];

  @override
  Future<List<FilteredUserModel>> getFilteredUsers(DatingFilterModel filter) async {
    await Future.delayed(const Duration(milliseconds: 800));

    List<FilteredUserModel> filteredUsers = _allUsers.where((user) {
      // 나이 필터링
      if (user.age < filter.minAge || user.age > filter.maxAge) {
        return false;
      }

      // 키 필터링
      if (user.height < filter.minHeight || user.height > filter.maxHeight) {
        return false;
      }

      // 거리 필터링
      if (user.distance > filter.distance) {
        return false;
      }

      // 흡연 필터링
      if (filter.smokingPreference != null && user.smokingType != filter.smokingPreference) {
        return false;
      }

      // 음주 필터링
      if (filter.drinkingPreference != null && user.drinkingType != filter.drinkingPreference) {
        return false;
      }

      // 지역 필터링 (간단하게 포함 여부로 체크)
      if (!user.location.contains(filter.location) && filter.location != '한국') {
        return false;
      }

      return true;
    }).toList();

    // 거리순으로 정렬
    filteredUsers.sort((a, b) => a.distance.compareTo(b.distance));

    return filteredUsers;
  }
}