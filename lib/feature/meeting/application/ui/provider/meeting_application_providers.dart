import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasource/meeting_apply_remote_datasource_impl.dart';
import '../../data/repository_impl/meeting_application_repository_impl.dart';
import '../../domain/repository/meeting_application_repository.dart';
import '../../domain/usecase/submit_meeting_application_usecase.dart';
import '../notifier/meeting_application_notifier.dart';
import '../state/meeting_application_state.dart';

// 환경에 맞게 baseUrl은 주입(예: .env, Flavors)
final _httpClientProvider = Provider<http.Client>((ref) => http.Client());
final _baseUrlProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.example.com',
  ),
);

final _remoteDsProvider = Provider((ref) {
  return MeetingApplyRemoteDataSourceImpl(
    baseUrl: ref.watch(_baseUrlProvider),
    client: ref.watch(_httpClientProvider),
  );
});

final meetingApplicationRepositoryProvider =
    Provider<MeetingApplicationRepository>((ref) {
      return MeetingApplicationRepositoryImpl(
        remote: ref.watch(_remoteDsProvider),
      );
    });

final submitMeetingApplicationUseCaseProvider = Provider(
  (ref) => SubmitMeetingApplicationUseCase(
    ref.watch(meetingApplicationRepositoryProvider),
  ),
);

final meetingApplicationNotifierProvider =
    StateNotifierProvider<MeetingApplicationNotifier, MeetingApplicationState>(
      (ref) => MeetingApplicationNotifier(
        ref.watch(submitMeetingApplicationUseCaseProvider),
      ),
    );
