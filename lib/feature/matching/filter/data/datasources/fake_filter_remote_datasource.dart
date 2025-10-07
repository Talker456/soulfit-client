import '../../domain/entities/dating_filter.dart';
import '../models/dating_filter_model.dart';
import '../models/filtered_user_model.dart';
import 'filter_remote_datasource.dart';

class FakeFilterRemoteDataSource implements FilterRemoteDataSource {
  final List<FilteredUserModel> _allUsers = [
    const FilteredUserModel(
      userId: 1,
      nickname: '김민수',
      age: 25,
      height: 175,
      location: '서울시 강남구',
      profileImageUrl: 'https://example.com/profile1.jpg',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.SOMETIMES,
      distanceInKm: 5.2,
    ),
    const FilteredUserModel(
      userId: 2,
      nickname: '이지현',
      age: 23,
      height: 162,
      location: '서울시 홍대',
      profileImageUrl: 'https://example.com/profile2.jpg',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.NEVER,
      distanceInKm: 12.8,
    ),
    const FilteredUserModel(
      userId: 3,
      nickname: '박준혁',
      age: 28,
      height: 180,
      location: '경기도 수원시',
      profileImageUrl: 'https://example.com/profile3.jpg',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.DAILY,
      distanceInKm: 25.5,
    ),
    const FilteredUserModel(
      userId: 4,
      nickname: '최서연',
      age: 26,
      height: 165,
      location: '서울시 잠실',
      profileImageUrl: 'https://example.com/profile4.jpg',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.SOMETIMES,
      distanceInKm: 8.1,
    ),
    const FilteredUserModel(
      userId: 5,
      nickname: '정도현',
      age: 30,
      height: 178,
      location: '인천시',
      profileImageUrl: 'https://example.com/profile5.jpg',
      smokingStatus: SmokingStatus.NON_SMOKER,
      drinkingStatus: DrinkingStatus.DAILY,
      distanceInKm: 35.7,
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
      // API 명세에 location 필터가 region으로 변경되었으므로, user.location과 filter.region을 비교
      // user.location이 nullable이므로 null 체크 추가
      if (user.location != null && !user.location!.contains(filter.region) && filter.region != 'Seoul') {
        return false;
      }

      // currentUserLatitude, currentUserLongitude는 현재 Fake에서는 사용하지 않음

      return true;
    }).toList();

    // 거리순으로 정렬
    filteredUsers.sort((a, b) => a.distanceInKm.compareTo(b.distanceInKm));

    return filteredUsers;
  }
}
