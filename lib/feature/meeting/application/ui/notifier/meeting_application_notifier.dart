import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/meeting_application.dart';
import '../../domain/usecase/submit_meeting_application_usecase.dart';
import '../state/meeting_application_state.dart';

class MeetingApplicationNotifier
    extends StateNotifier<MeetingApplicationState> {
  final SubmitMeetingApplicationUseCase _submitUseCase;

  MeetingApplicationNotifier(this._submitUseCase)
    : super(MeetingApplicationState.initial());

  Future<void> submit(MeetingApplication application) async {
    state = state.copyWith(submitting: true, error: null, submitted: false);
    try {
      final ok = await _submitUseCase(application);
      state = state.copyWith(submitting: false, submitted: ok);
    } catch (e) {
      state = state.copyWith(submitting: false, error: e.toString());
    }
  }

  void reset() {
    state = MeetingApplicationState.initial();
  }
}
