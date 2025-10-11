import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:soulfit_client/config/di/provider.dart';
import '../../domain/entities/vote_form.dart';
import '../../domain/entities/vote_target.dart';
import '../../domain/entities/vote_response.dart';
import '../../domain/entities/vote_result.dart';
import '../../domain/usecases/create_vote_form_usecase.dart';
import '../../domain/usecases/get_vote_targets_usecase.dart';
import '../../domain/usecases/submit_vote_response_usecase.dart';
import '../../domain/usecases/get_vote_results_usecase.dart';
import '../../data/repository_impl/voting_repository_impl.dart';
import '../../data/datasources/voting_remote_datasource_impl.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';

// Provider 계층 구조
final _httpClientProvider = Provider<http.Client>((ref) => http.Client());

final _authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: const FlutterSecureStorage());
});

final _votingRemoteDataSourceProvider = Provider((ref) {
  final client = ref.watch(_httpClientProvider);
  final authSource = ref.watch(_authLocalDataSourceProvider);

  return VotingRemoteDataSourceImpl(
    client: client,
    authSource: authSource,
    baseUrl: BASE_URL,
  );
});

final _votingRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(_votingRemoteDataSourceProvider);
  return VotingRepositoryImpl(remoteDataSource: remoteDataSource);
});

final _createVoteFormUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_votingRepositoryProvider);
  return CreateVoteFormUseCase(repository);
});

final _getVoteTargetsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_votingRepositoryProvider);
  return GetVoteTargetsUseCase(repository);
});

final _submitVoteResponseUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_votingRepositoryProvider);
  return SubmitVoteResponseUseCase(repository);
});

final _getVoteResultsUseCaseProvider = Provider((ref) {
  final repository = ref.watch(_votingRepositoryProvider);
  return GetVoteResultsUseCase(repository);
});

/// Voting State
/// 투표 기능의 전체 상태를 관리
class VotingState {
  final VoteForm? currentVoteForm;
  final List<VoteTarget> voteTargets;
  final VoteResult? voteResult;
  final bool isLoading;
  final String? error;
  final int currentTargetIndex; // 현재 투표 중인 대상 인덱스

  const VotingState({
    this.currentVoteForm,
    this.voteTargets = const [],
    this.voteResult,
    this.isLoading = false,
    this.error,
    this.currentTargetIndex = 0,
  });

  VotingState copyWith({
    VoteForm? currentVoteForm,
    List<VoteTarget>? voteTargets,
    VoteResult? voteResult,
    bool? isLoading,
    String? error,
    int? currentTargetIndex,
  }) {
    return VotingState(
      currentVoteForm: currentVoteForm ?? this.currentVoteForm,
      voteTargets: voteTargets ?? this.voteTargets,
      voteResult: voteResult ?? this.voteResult,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      currentTargetIndex: currentTargetIndex ?? this.currentTargetIndex,
    );
  }
}

/// Voting Notifier
/// 투표 기능의 비즈니스 로직을 처리
class VotingNotifier extends StateNotifier<VotingState> {
  final CreateVoteFormUseCase _createVoteFormUseCase;
  final GetVoteTargetsUseCase _getVoteTargetsUseCase;
  final SubmitVoteResponseUseCase _submitVoteResponseUseCase;
  final GetVoteResultsUseCase _getVoteResultsUseCase;

  VotingNotifier(
    this._createVoteFormUseCase,
    this._getVoteTargetsUseCase,
    this._submitVoteResponseUseCase,
    this._getVoteResultsUseCase,
  ) : super(const VotingState());

  /// 투표 폼 생성
  Future<void> createVoteForm({
    required String imageUrl,
    required String title,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final voteForm = await _createVoteFormUseCase.execute(
        imageUrl: imageUrl,
        title: title,
      );
      state = state.copyWith(
        currentVoteForm: voteForm,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 투표 대상 목록 로드
  Future<void> loadVoteTargets(int voteFormId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final targets = await _getVoteTargetsUseCase.execute(voteFormId);
      state = state.copyWith(
        voteTargets: targets,
        currentTargetIndex: 0,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 투표 응답 제출
  Future<void> submitVote({
    required int voteFormId,
    required int targetUserId,
    required VoteChoice choice,
  }) async {
    try {
      final response = VoteResponse(
        voteFormId: voteFormId,
        targetUserId: targetUserId,
        choice: choice,
      );

      await _submitVoteResponseUseCase.execute(response);

      // 다음 대상으로 이동
      if (state.currentTargetIndex < state.voteTargets.length - 1) {
        state = state.copyWith(
          currentTargetIndex: state.currentTargetIndex + 1,
        );
      } else {
        // 마지막 투표 완료
        state = state.copyWith(
          currentTargetIndex: 0,
          voteTargets: [],
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 투표 결과 로드
  Future<void> loadVoteResults(int voteFormId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final results = await _getVoteResultsUseCase.execute(voteFormId);
      state = state.copyWith(
        voteResult: results,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 상태 초기화
  void reset() {
    state = const VotingState();
  }

  /// 현재 투표 대상 가져오기
  VoteTarget? get currentTarget {
    if (state.voteTargets.isEmpty ||
        state.currentTargetIndex >= state.voteTargets.length) {
      return null;
    }
    return state.voteTargets[state.currentTargetIndex];
  }
}

/// Voting Provider
/// UI에서 사용할 메인 Provider
final votingProvider = StateNotifierProvider<VotingNotifier, VotingState>((ref) {
  final createVoteFormUseCase = ref.watch(_createVoteFormUseCaseProvider);
  final getVoteTargetsUseCase = ref.watch(_getVoteTargetsUseCaseProvider);
  final submitVoteResponseUseCase = ref.watch(_submitVoteResponseUseCaseProvider);
  final getVoteResultsUseCase = ref.watch(_getVoteResultsUseCaseProvider);

  return VotingNotifier(
    createVoteFormUseCase,
    getVoteTargetsUseCase,
    submitVoteResponseUseCase,
    getVoteResultsUseCase,
  );
});
