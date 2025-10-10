import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/filter/domain/entities/dating_filter.dart';
import 'package:soulfit_client/feature/matching/filter/domain/entities/filtered_user.dart';
import 'package:soulfit_client/feature/matching/filter/domain/usecases/clear_saved_filter_usecase.dart';
import 'package:soulfit_client/feature/matching/filter/domain/usecases/get_filtered_users_usecase.dart';
import 'package:soulfit_client/feature/matching/filter/domain/usecases/get_saved_filter_usecase.dart';
import 'package:soulfit_client/feature/matching/filter/domain/usecases/save_filter_usecase.dart';

class DatingFilterState {
  final DatingFilter filter;
  final List<FilteredUser> users;
  final bool isLoading;
  final String? errorMessage;

  DatingFilterState({
    required this.filter,
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  DatingFilterState copyWith({
    DatingFilter? filter,
    List<FilteredUser>? users,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DatingFilterState(
      filter: filter ?? this.filter,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DatingFilterNotifier extends StateNotifier<DatingFilterState> {
  final GetSavedFilterUseCase getSavedFilterUseCase;
  final SaveFilterUseCase saveFilterUseCase;
  final ClearSavedFilterUseCase clearSavedFilterUseCase;
  final GetFilteredUsersUseCase getFilteredUsersUseCase;

  DatingFilterNotifier({
    required this.getSavedFilterUseCase,
    required this.saveFilterUseCase,
    required this.clearSavedFilterUseCase,
    required this.getFilteredUsersUseCase,
  }) : super(DatingFilterState(filter: DatingFilter.defaultFilter)) {
    loadSavedFilter();
  }

  Future<void> loadSavedFilter() async {
    state = state.copyWith(isLoading: true);
    try {
      final savedFilter = await getSavedFilterUseCase();
      state = state.copyWith(filter: savedFilter ?? DatingFilter.defaultFilter, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> saveFilter() async {
    state = state.copyWith(isLoading: true);
    try {
      await saveFilterUseCase(state.filter);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> clearFilter() async {
    state = state.copyWith(isLoading: true);
    try {
      await clearSavedFilterUseCase();
      state = state.copyWith(filter: DatingFilter.defaultFilter, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> getFilteredUsers() async {
    state = state.copyWith(isLoading: true, users: []);
    try {
      final users = await getFilteredUsersUseCase(state.filter);
      state = state.copyWith(users: users, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  void updateCurrentUserLatitude(double latitude) {
    state = state.copyWith(filter: state.filter.copyWith(currentUserLatitude: latitude));
  }

  void updateCurrentUserLongitude(double longitude) {
    state = state.copyWith(filter: state.filter.copyWith(currentUserLongitude: longitude));
  }

  void updateRegion(String region) {
    state = state.copyWith(filter: state.filter.copyWith(region: region));
  }

  void updateMinAge(int minAge) {
    state = state.copyWith(filter: state.filter.copyWith(minAge: minAge));
  }

  void updateMaxAge(int maxAge) {
    state = state.copyWith(filter: state.filter.copyWith(maxAge: maxAge));
  }

  void updateMaxDistanceInKm(int distance) {
    state = state.copyWith(filter: state.filter.copyWith(maxDistanceInKm: distance));
  }

  void updateSmokingStatus(SmokingStatus? status) {
    state = state.copyWith(filter: state.filter.copyWith(smokingStatus: status));
  }

  void updateDrinkingStatus(DrinkingStatus? status) {
    state = state.copyWith(filter: state.filter.copyWith(drinkingStatus: status));
  }

  void updateMinHeight(int? minHeight) {
    state = state.copyWith(filter: state.filter.copyWith(minHeight: minHeight));
  }

  void updateMaxHeight(int? maxHeight) {
    state = state.copyWith(filter: state.filter.copyWith(maxHeight: maxHeight));
  }
}

