import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/data/datasource/meeting_dashboard_remote_data_source.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/data/datasource/meeting_dashboard_remote_data_source_impl.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/data/repository_impl/meeting_dashboard_repository_impl.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/repository/meeting_dashboard_repository.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/usecase/get_meeting_dashboard_stats_usecase.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/usecase/get_participated_meetings_usecase.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/notifier/meeting_dashboard_notifier.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/state/meeting_dashboard_state.dart';

// Data Layer Providers
final meetingDashboardRemoteDataSourceProvider =
    Provider<MeetingDashboardRemoteDataSource>((ref) {
  // TODO: Implement FakeDataSource for testing
  // if (USE_FAKE_DATASOURCE) {
  //   return MeetingDashboardFakeRemoteDataSource();
  // }
  return MeetingDashboardRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    source: ref.read(authLocalDataSourceProvider),
    base: BASE_URL,
  );
});

final meetingDashboardRepositoryProvider = Provider<MeetingDashboardRepository>((ref) {
  final remoteDataSource = ref.watch(meetingDashboardRemoteDataSourceProvider);
  return MeetingDashboardRepositoryImpl(remoteDataSource);
});

// Domain Layer (Use Case) Providers
final getMeetingDashboardStatsUseCaseProvider = Provider<GetMeetingDashboardStatsUseCase>((ref) {
  final repository = ref.watch(meetingDashboardRepositoryProvider);
  return GetMeetingDashboardStatsUseCase(repository);
});

final getParticipatedMeetingsUseCaseProvider = Provider<GetParticipatedMeetingsUseCase>((ref) {
  final repository = ref.watch(meetingDashboardRepositoryProvider);
  return GetParticipatedMeetingsUseCase(repository);
});

// Presentation Layer (Notifier) Provider
final meetingDashboardNotifierProvider =
    StateNotifierProvider.autoDispose<MeetingDashboardNotifier, MeetingDashboardState>((ref) {
  final getStatsUseCase = ref.watch(getMeetingDashboardStatsUseCaseProvider);
  final getMeetingsUseCase = ref.watch(getParticipatedMeetingsUseCaseProvider);

  return MeetingDashboardNotifier(
    getStatsUseCase: getStatsUseCase,
    getMeetingsUseCase: getMeetingsUseCase,
  );
});
