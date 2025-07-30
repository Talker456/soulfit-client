// lib/feature/meeting_report/presentation/riverpod/meeting_report_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/meeting_report_request.dart';
import '../../domain/usecases/submit_meeting_report.dart';
import '../../data/repository_impl/meeting_report_repository_impl.dart';
import '../../data/datasources/meeting_report_remote_datasource.dart';
import 'package:dio/dio.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final meetingReportApiProvider = Provider<MeetingReportApi>((ref) {
  final dio = ref.read(dioProvider);
  return MeetingReportApi(dio: dio);
});

final meetingReportRepositoryProvider = Provider<MeetingReportRepositoryImpl>((
  ref,
) {
  final api = ref.read(meetingReportApiProvider);
  return MeetingReportRepositoryImpl(remoteDataSource: api);
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
