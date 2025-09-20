
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/matching/review/data/datasource/review_remote_datasource.dart';
import 'package:soulfit_client/feature/matching/review/data/datasource/review_remote_datasource_impl.dart';
import 'package:soulfit_client/feature/matching/review/data/repository_impl/review_repository_impl.dart';
import 'package:soulfit_client/feature/matching/review/domain/repository/review_repository.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/create_review.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_my_reviews.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_review_keywords.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_reviews_for_user.dart';
import 'package:soulfit_client/feature/matching/review/domain/usecase/get_user_keyword_summary.dart';
import 'package:soulfit_client/feature/matching/review/presentation/riverpod/create_review_riverpod.dart';
import 'package:soulfit_client/feature/matching/review/presentation/riverpod/my_reviews_riverpod.dart';
import 'package:soulfit_client/feature/matching/review/presentation/riverpod/user_reviews_riverpod.dart';

import '../state/create_review_state.dart';
import '../state/my_reviews_state.dart';
import '../state/user_reviews_state.dart';

// Layer 1: DataSource
final reviewRemoteDataSourceProvider = Provider<ReviewRemoteDataSource>((ref) {
  return ReviewRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    authLocalDataSource: ref.read(authLocalDataSourceProvider),
    baseUrl: BASE_URL,
  );
});

// Layer 2: Repository
final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  final remoteDataSource = ref.watch(reviewRemoteDataSourceProvider);
  return ReviewRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Layer 3: UseCases
final createReviewUseCaseProvider = Provider<CreateReviewUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return CreateReviewUseCase(repository);
});

final getReviewsForUserUseCaseProvider = Provider<GetReviewsForUserUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetReviewsForUserUseCase(repository);
});

final getMyReviewsUseCaseProvider = Provider<GetMyReviewsUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetMyReviewsUseCase(repository);
});

final getReviewKeywordsUseCaseProvider = Provider<GetReviewKeywordsUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetReviewKeywordsUseCase(repository);
});

final getUserKeywordSummaryUseCaseProvider = Provider<GetUserKeywordSummaryUseCase>((ref) {
  final repository = ref.watch(reviewRepositoryProvider);
  return GetUserKeywordSummaryUseCase(repository);
});


// Layer 4: Notifier
final createReviewNotifierProvider = StateNotifierProvider.autoDispose<CreateReviewNotifier, CreateReviewState>((ref) {
  return CreateReviewNotifier(
    ref.watch(createReviewUseCaseProvider),
    ref.watch(getReviewKeywordsUseCaseProvider),
  );
});

final userReviewsNotifierProvider = StateNotifierProvider.autoDispose.family<UserReviewsNotifier, UserReviewsState, int>((ref, userId) {
  return UserReviewsNotifier(
    ref.watch(getReviewsForUserUseCaseProvider),
  )..fetchUserReviews(userId);
});

final myReviewsNotifierProvider = StateNotifierProvider.autoDispose<MyReviewsNotifier, MyReviewsState>((ref) {
  return MyReviewsNotifier(
    ref.watch(getMyReviewsUseCaseProvider),
  )..fetchMyReviews();
});
