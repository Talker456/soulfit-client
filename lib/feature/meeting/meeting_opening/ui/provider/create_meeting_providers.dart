import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../../data/datasources/meeting_remote_datasource_impl.dart';
import '../../data/repository_impl/meeting_repository_impl.dart';
import '../../domain/usecases/create_meeting_usecase.dart';
import '../notifier/create_meeting_notifier.dart';
import '../state/create_meeting_state.dart';

// BASE_URL 상수 (프로젝트 표준 패턴)
const bool _IS_AVD = false; // Android Virtual Device 사용 시 true로 변경
const String _BASE_URL = _IS_AVD ? "10.0.2.2" : "localhost";

// HTTP Client Provider
final _httpClientProvider = Provider<http.Client>((ref) => http.Client());

// Auth Local DataSource Provider
final _authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: const FlutterSecureStorage());
});

// Meeting Remote DataSource Provider
final _meetingRemoteDataSourceProvider = Provider((ref) {
  return MeetingRemoteDataSourceImpl(
    client: ref.watch(_httpClientProvider),
    authSource: ref.watch(_authLocalDataSourceProvider),
    baseUrl: _BASE_URL,
  );
});

// Meeting Repository Provider
final _meetingRepositoryProvider = Provider((ref) {
  return MeetingRepositoryImpl(
    remoteDataSource: ref.watch(_meetingRemoteDataSourceProvider),
  );
});

// Create Meeting UseCase Provider
final _createMeetingUseCaseProvider = Provider((ref) {
  return CreateMeetingUseCase(ref.watch(_meetingRepositoryProvider));
});

// Create Meeting Notifier Provider
final createMeetingProvider =
    StateNotifierProvider<CreateMeetingNotifier, CreateMeetingState>((ref) {
      return CreateMeetingNotifier(
        ref.watch(_createMeetingUseCaseProvider),
      );
    });
