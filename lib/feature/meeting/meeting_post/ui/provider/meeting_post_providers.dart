import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../authentication/data/datasource/auth_local_datasource.dart';
import '../../data/datasources/meeting_post_remote_datasource_impl.dart';
import '../../data/repository_impl/meeting_post_repository_impl.dart';
import '../../domain/usecases/get_meeting_post_detail_usecase.dart';
import '../notifier/meeting_post_notifier.dart';
import '../state/meeting_post_state.dart';

// BASE_URL 상수 (프로젝트 표준 패턴)
const bool _IS_AVD = false; // Android Virtual Device 사용 시 true로 변경
const String _BASE_URL = _IS_AVD ? "10.0.2.2" : "localhost";

// HTTP Client Provider
final _httpClientProvider = Provider<http.Client>((ref) => http.Client());

// Auth Local DataSource Provider
final _authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: const FlutterSecureStorage());
});

// Meeting Post Remote DataSource Provider
final _meetingPostRemoteDataSourceProvider = Provider((ref) {
  return MeetingPostRemoteDataSourceImpl(
    client: ref.watch(_httpClientProvider),
    authSource: ref.watch(_authLocalDataSourceProvider),
    baseUrl: _BASE_URL,
  );
});

// Meeting Post Repository Provider
final _meetingPostRepositoryProvider = Provider((ref) {
  return MeetingPostRepositoryImpl(
    remoteDataSource: ref.watch(_meetingPostRemoteDataSourceProvider),
  );
});

// Get Meeting Post Detail UseCase Provider
final _getMeetingPostDetailUseCaseProvider = Provider((ref) {
  return GetMeetingPostDetailUseCase(ref.watch(_meetingPostRepositoryProvider));
});

// Meeting Post Notifier Provider
final meetingPostProvider =
    StateNotifierProvider<MeetingPostNotifier, MeetingPostState>((ref) {
      return MeetingPostNotifier(
        ref.watch(_getMeetingPostDetailUseCaseProvider),
      );
    });
