import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/entities/recommended_user.dart';
import '../../domain/entities/first_impression_vote.dart';
import '../../domain/usecases/get_recommended_users_usecase.dart';
import '../../domain/usecases/get_latest_first_impression_vote_usecase.dart';
import '../../domain/usecases/mark_first_impression_vote_as_read_usecase.dart';
import '../../data/repositories/dating_main_repository_impl.dart';
import '../../data/datasources/dating_main_remote_datasource_impl.dart';
import '../../data/datasources/dating_main_fake_datasource.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';

final _httpClientProvider = Provider<http.Client>((ref) => http.Client());

final _authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: const FlutterSecureStorage());
});

final _datingMainRemoteDataSourceProvider = Provider((ref) {
  final client = ref.watch(_httpClientProvider);
  final authSource = ref.watch(_authLocalDataSourceProvider);

  const bool useFakeData = true;

  if (useFakeData) {
    return DatingMainFakeDataSource();
  } else {
    return DatingMainRemoteDataSourceImpl(
      client: client,
      authSource: authSource,
      baseUrl: 'your-api-base-url.com',
    );
  }
});

final _datingMainRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(_datingMainRemoteDataSourceProvider);
  return DatingMainRepositoryImpl(remoteDataSource: remoteDataSource);
});

final _getRecommendedUsersUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_datingMainRepositoryProvider);
  return GetRecommendedUsersUseCase(repository);
});

final _getLatestFirstImpressionVoteUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_datingMainRepositoryProvider);
  return GetLatestFirstImpressionVoteUseCase(repository);
});

final _markFirstImpressionVoteAsReadUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_datingMainRepositoryProvider);
  return MarkFirstImpressionVoteAsReadUseCase(repository);
});

class DatingMainState {
  final List<RecommendedUser> recommendedUsers;
  final FirstImpressionVote? latestVote;
  final bool isLoadingUsers;
  final bool isLoadingVote;
  final String? error;

  const DatingMainState({
    this.recommendedUsers = const [],
    this.latestVote,
    this.isLoadingUsers = false,
    this.isLoadingVote = false,
    this.error,
  });

  DatingMainState copyWith({
    List<RecommendedUser>? recommendedUsers,
    FirstImpressionVote? latestVote,
    bool? isLoadingUsers,
    bool? isLoadingVote,
    String? error,
  }) {
    return DatingMainState(
      recommendedUsers: recommendedUsers ?? this.recommendedUsers,
      latestVote: latestVote ?? this.latestVote,
      isLoadingUsers: isLoadingUsers ?? this.isLoadingUsers,
      isLoadingVote: isLoadingVote ?? this.isLoadingVote,
      error: error ?? this.error,
    );
  }
}

class DatingMainNotifier extends StateNotifier<DatingMainState> {
  final GetRecommendedUsersUseCase _getRecommendedUsersUseCase;
  final GetLatestFirstImpressionVoteUseCase _getLatestFirstImpressionVoteUseCase;
  final MarkFirstImpressionVoteAsReadUseCase _markFirstImpressionVoteAsReadUseCase;

  DatingMainNotifier(
    this._getRecommendedUsersUseCase,
    this._getLatestFirstImpressionVoteUseCase,
    this._markFirstImpressionVoteAsReadUseCase,
  ) : super(const DatingMainState());

  Future<void> loadRecommendedUsers({int limit = 10}) async {
    try {
      state = state.copyWith(isLoadingUsers: true, error: null);
      final users = await _getRecommendedUsersUseCase(limit: limit);
      state = state.copyWith(
        recommendedUsers: users,
        isLoadingUsers: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingUsers: false,
        error: e.toString(),
      );
    }
  }

  Future<void> loadLatestFirstImpressionVote() async {
    try {
      state = state.copyWith(isLoadingVote: true, error: null);
      final vote = await _getLatestFirstImpressionVoteUseCase();
      state = state.copyWith(
        latestVote: vote,
        isLoadingVote: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingVote: false,
        error: e.toString(),
      );
    }
  }

  Future<void> markVoteAsRead(String voteId) async {
    try {
      await _markFirstImpressionVoteAsReadUseCase(voteId);
      if (state.latestVote?.id == voteId) {
        state = state.copyWith(latestVote: null);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

final datingMainProvider = StateNotifierProvider<DatingMainNotifier, DatingMainState>((ref) {
  final getRecommendedUsersUseCase = ref.watch(_getRecommendedUsersUseCaseProvider);
  final getLatestFirstImpressionVoteUseCase = ref.watch(_getLatestFirstImpressionVoteUseCaseProvider);
  final markFirstImpressionVoteAsReadUseCase = ref.watch(_markFirstImpressionVoteAsReadUseCaseProvider);

  return DatingMainNotifier(
    getRecommendedUsersUseCase,
    getLatestFirstImpressionVoteUseCase,
    markFirstImpressionVoteAsReadUseCase,
  );
});