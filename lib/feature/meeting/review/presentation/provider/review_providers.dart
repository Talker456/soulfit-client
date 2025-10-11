import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../../data/datasources/review_remote_datasource_impl.dart';
import '../../data/repository_impl/review_repository_impl.dart';
import '../../domain/usecases/get_reviews_usecase.dart';
import '../../domain/usecases/get_review_stats_usecase.dart';
import '../../domain/usecases/create_review_usecase.dart';
import '../notifier/review_notifier.dart';
import '../notifier/create_review_notifier.dart';
import '../state/review_state.dart';

// BASE_URL 상수 (프로젝트 표준 패턴)
const bool _IS_AVD = false; // Android Virtual Device 사용 시 true로 변경
const String _BASE_URL = _IS_AVD ? "10.0.2.2" : "localhost";

// HTTP Client Provider
final _httpClientProvider = Provider<http.Client>((ref) => http.Client());

// Auth Local DataSource Provider
final _authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: const FlutterSecureStorage());
});

// Review Remote DataSource Provider
final _reviewRemoteDataSourceProvider = Provider((ref) {
  return ReviewRemoteDataSourceImpl(
    client: ref.watch(_httpClientProvider),
    authSource: ref.watch(_authLocalDataSourceProvider),
    baseUrl: _BASE_URL,
  );
});

// Review Repository Provider
final _reviewRepositoryProvider = Provider((ref) {
  return ReviewRepositoryImpl(
    remoteDataSource: ref.watch(_reviewRemoteDataSourceProvider),
  );
});

// UseCases
final _getReviewsUseCaseProvider = Provider((ref) {
  return GetReviewsUseCase(ref.watch(_reviewRepositoryProvider));
});

final _getReviewStatsUseCaseProvider = Provider((ref) {
  return GetReviewStatsUseCase(ref.watch(_reviewRepositoryProvider));
});

final _createReviewUseCaseProvider = Provider((ref) {
  return CreateReviewUseCase(ref.watch(_reviewRepositoryProvider));
});

// Review Notifier Provider
final reviewProvider = StateNotifierProvider<ReviewNotifier, ReviewState>((ref) {
  return ReviewNotifier(
    getReviewsUseCase: ref.watch(_getReviewsUseCaseProvider),
    getReviewStatsUseCase: ref.watch(_getReviewStatsUseCaseProvider),
  );
});

// Create Review Notifier Provider
final createReviewProvider =
    StateNotifierProvider<CreateReviewNotifier, CreateReviewState>((ref) {
  return CreateReviewNotifier(
    ref.watch(_createReviewUseCaseProvider),
  );
});
