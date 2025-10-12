// lib/feature/meeting_report/presentation/riverpod/meeting_report_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/meeting_report_request.dart';
import '../../domain/usecases/submit_meeting_report.dart';
import '../../data/repository_impl/meeting_report_repository_impl.dart';
import '../../data/datasources/meeting_report_remote_datasource.dart';
import '../../../../config/di/provider.dart';

final meetingReportRemoteDataSourceProvider = Provider<MeetingReportRemoteDataSource>((ref) {
  // TODO: Fake DataSource 구현 시 USE_FAKE_DATASOURCE 스위치 추가
  return MeetingReportRemoteDataSourceImpl(
    client: ref.read(httpClientProvider),
    source: ref.read(authLocalDataSourceProvider),
    baseUrl: BASE_URL,
  );
});

final meetingReportRepositoryProvider = Provider<MeetingReportRepositoryImpl>((
  ref,
) {
  final remoteDataSource = ref.watch(meetingReportRemoteDataSourceProvider);
  return MeetingReportRepositoryImpl(remoteDataSource: remoteDataSource);
});

final reportMeetingUseCaseProvider = Provider<ReportMeetingUseCase>((ref) {
  final repository = ref.read(meetingReportRepositoryProvider);
  return ReportMeetingUseCase(repository: repository);
});

final meetingReportProvider =
    AsyncNotifierProvider<MeetingReportNotifier, void>(
      MeetingReportNotifier.new,
    );

class MeetingReportNotifier extends AsyncNotifier<void> {
  late final ReportMeetingUseCase _useCase;

  @override
  Future<void> build() async {
    _useCase = ref.read(reportMeetingUseCaseProvider);
  }

  Future<void> reportMeeting({
    required String reporterUserId,
    required String meetingId,
    required String reason,
  }) async {
    state = const AsyncLoading();

    try {
      final request = MeetingReportRequest(
        reporterUserId: reporterUserId,
        meetingId: meetingId,
        reason: reason,
      );
      await _useCase.call(request);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
