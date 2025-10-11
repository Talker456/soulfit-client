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

// BASE_URL 상수를 사용 (프로젝트 표준 패턴)
const bool _IS_AVD = false; // Android Virtual Device 사용 시 true로 변경
const String _BASE_URL = _IS_AVD ? "10.0.2.2" : "localhost";

final _baseUrlProvider = Provider<String>((ref) => 'http://$_BASE_URL:8080');

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
