import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/dating_filter.dart';
import '../../domain/entities/filtered_user.dart';
import '../../domain/usecases/get_filtered_users_usecase.dart';
import '../../domain/usecases/save_filter_usecase.dart';
import '../../domain/usecases/get_saved_filter_usecase.dart';
import '../../domain/usecases/clear_saved_filter_usecase.dart';
import '../../data/repository_impl/filter_repository_impl.dart';
import '../../data/datasources/filter_remote_datasource_impl.dart';
import '../../data/datasources/fake_filter_remote_datasource.dart';
import '../../data/datasources/filter_local_datasource_impl.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Provider 설정들 (DI 대신 직접 정의)
const bool USE_FAKE_DATASOURCE = true;
const bool _IS_AVD = false;
const String BASE_URL = _IS_AVD ? "10.0.2.2" : "localhost";

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: ref.read(secureStorageProvider));
});

final filterRemoteDataSourceProvider = Provider((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeFilterRemoteDataSource();
  } else {
    return FilterRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      authSource: ref.read(authLocalDataSourceProvider),
      baseUrl: BASE_URL,
    );
  }
});

final filterLocalDataSourceProvider = Provider((ref) {
  return FilterLocalDataSourceImpl(
    storage: ref.read(secureStorageProvider),
  );
});

final filterRepositoryProvider = Provider((ref) {
  return FilterRepositoryImpl(
    remoteDataSource: ref.read(filterRemoteDataSourceProvider),
    localDataSource: ref.read(filterLocalDataSourceProvider),
  );
});

final getSavedFilterUseCaseProvider = Provider<GetSavedFilterUseCase>((ref) {
  return GetSavedFilterUseCase(ref.read(filterRepositoryProvider));
});

final saveFilterUseCaseProvider = Provider<SaveFilterUseCase>((ref) {
  return SaveFilterUseCase(ref.read(filterRepositoryProvider));
});

final clearSavedFilterUseCaseProvider = Provider<ClearSavedFilterUseCase>((ref) {
  return ClearSavedFilterUseCase(ref.read(filterRepositoryProvider));
});

final getFilteredUsersUseCaseProvider = Provider<GetFilteredUsersUseCase>((ref) {
  return GetFilteredUsersUseCase(ref.read(filterRepositoryProvider));
});

// 현재 필터 상태를 관리하는 Provider
final datingFilterProvider = StateNotifierProvider<DatingFilterNotifier, DatingFilter>((ref) {
  final getSavedFilterUseCase = ref.watch(getSavedFilterUseCaseProvider);
  final saveFilterUseCase = ref.watch(saveFilterUseCaseProvider);
  final clearSavedFilterUseCase = ref.watch(clearSavedFilterUseCaseProvider);

  return DatingFilterNotifier(
    getSavedFilterUseCase: getSavedFilterUseCase,
    saveFilterUseCase: saveFilterUseCase,
    clearSavedFilterUseCase: clearSavedFilterUseCase,
  );
});

// 필터링된 사용자 목록을 관리하는 Provider
final filteredUsersProvider = StateNotifierProvider<FilteredUsersNotifier, AsyncValue<List<FilteredUser>>>((ref) {
  final getFilteredUsersUseCase = ref.watch(getFilteredUsersUseCaseProvider);
  final currentFilter = ref.watch(datingFilterProvider);

  return FilteredUsersNotifier(
    getFilteredUsersUseCase: getFilteredUsersUseCase,
    currentFilter: currentFilter,
  );
});

class DatingFilterNotifier extends StateNotifier<DatingFilter> {
  final dynamic getSavedFilterUseCase;
  final dynamic saveFilterUseCase;
  final dynamic clearSavedFilterUseCase;

  DatingFilterNotifier({
    required this.getSavedFilterUseCase,
    required this.saveFilterUseCase,
    required this.clearSavedFilterUseCase,
  }) : super(DatingFilter.defaultFilter) {
    _loadSavedFilter();
  }

  Future<void> _loadSavedFilter() async {
    try {
      final savedFilter = await getSavedFilterUseCase();
      if (savedFilter != null) {
        state = savedFilter;
      }
    } catch (e) {
      // 에러 시 기본값 유지
    }
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
  }

  void updateHeightRange(double minHeight, double maxHeight) {
    state = state.copyWith(minHeight: minHeight, maxHeight: maxHeight);
  }

  void updateDistance(double distance) {
    state = state.copyWith(distance: distance);
  }

  void updateAgeRange(int minAge, int maxAge) {
    state = state.copyWith(minAge: minAge, maxAge: maxAge);
  }

  void updateSmokingPreference(SmokingType? smokingType) {
    state = state.copyWith(smokingPreference: smokingType);
  }

  void updateDrinkingPreference(DrinkingType? drinkingType) {
    state = state.copyWith(drinkingPreference: drinkingType);
  }

  Future<void> saveCurrentFilter() async {
    try {
      await saveFilterUseCase(state);
    } catch (e) {
      // 에러 처리
    }
  }

  Future<void> resetToDefault() async {
    state = DatingFilter.defaultFilter;
    try {
      await clearSavedFilterUseCase();
    } catch (e) {
      // 에러 처리
    }
  }
}

class FilteredUsersNotifier extends StateNotifier<AsyncValue<List<FilteredUser>>> {
  final dynamic getFilteredUsersUseCase;
  final DatingFilter currentFilter;

  FilteredUsersNotifier({
    required this.getFilteredUsersUseCase,
    required this.currentFilter,
  }) : super(const AsyncValue.loading());

  Future<void> searchWithFilter(DatingFilter filter) async {
    state = const AsyncValue.loading();
    try {
      final users = await getFilteredUsersUseCase(filter);
      state = AsyncValue.data(users);
    } catch (error) {
      state = AsyncValue.error(error, StackTrace.current);
    }
  }

  Future<void> refresh() async {
    await searchWithFilter(currentFilter);
  }
}