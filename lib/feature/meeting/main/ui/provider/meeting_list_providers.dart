import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/fake_meeting_remote_data_source_impl.dart';
import '../../data/repository_impl/meeting_repository_impl.dart';
import '../../domain/repository/meeting_repository.dart';
import '../../domain/usecase/get_ai_recommended_meetings_usecase.dart';
import '../../domain/usecase/get_popular_meetings_usecase.dart';
import '../../domain/usecase/get_recently_created_meetings_usecase.dart';
import '../../domain/usecase/get_user_recent_joined_meetings_usecase.dart';
import '../notifier/meeting_list_notifier.dart';
import '../state/meeting_list_state.dart';

/// 🔧 Repository Provider
final meetingRepositoryProvider = Provider<MeetingRepository>((ref) {
  return MeetingRepositoryImpl(FakeMeetingRemoteDataSourceImpl());
});

/// ✅ UseCase Providers
final getAiRecommendedMeetingsUseCaseProvider = Provider((ref) {
  return GetAiRecommendedMeetingsUseCase(ref.watch(meetingRepositoryProvider));
});

final getPopularMeetingsUseCaseProvider = Provider((ref) {
  return GetPopularMeetingsUseCase(ref.watch(meetingRepositoryProvider));
});

final getRecentlyCreatedMeetingsUseCaseProvider = Provider((ref) {
  return GetRecentlyCreatedMeetingsUseCase(ref.watch(meetingRepositoryProvider));
});

final getUserRecentJoinedMeetingsUseCaseProvider = Provider((ref) {
  return GetUserRecentJoinedMeetingsUseCase(ref.watch(meetingRepositoryProvider));
});

/// 📦 StateNotifierProviders
final aiRecommendedMeetingsProvider = StateNotifierProvider<MeetingListNotifier, MeetingListState>((ref) {
  final useCase = ref.watch(getAiRecommendedMeetingsUseCaseProvider);
  return MeetingListNotifier(useCase: useCase);
});

final popularMeetingsProvider = StateNotifierProvider<MeetingListNotifier, MeetingListState>((ref) {
  final useCase = ref.watch(getPopularMeetingsUseCaseProvider);
  return MeetingListNotifier(useCase: useCase);
});

final recentlyCreatedMeetingsProvider = StateNotifierProvider<MeetingListNotifier, MeetingListState>((ref) {
  final useCase = ref.watch(getRecentlyCreatedMeetingsUseCaseProvider);
  return MeetingListNotifier(useCase: useCase);
});

final userRecentJoinedMeetingsProvider = StateNotifierProvider<MeetingListNotifier, MeetingListState>((ref) {
  final useCase = ref.watch(getUserRecentJoinedMeetingsUseCaseProvider);
  return MeetingListNotifier(useCase: useCase);
});

// 카테고리별 모임 목록
final meetingsByCategoryProvider = StateNotifierProvider.family<MeetingListNotifier, MeetingListState, String>((ref, category) {
  // TODO: 카테고리별 미팅을 가져오는 UseCase를 별도로 만들거나, 기존 UseCase를 수정해야 함
  final useCase = ref.watch(getPopularMeetingsUseCaseProvider);
  return MeetingListNotifier(useCase: useCase, category: category);
});
