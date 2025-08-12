import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/create_meeting_notifier.dart';
import '../state/create_meeting_state.dart';

final createMeetingProvider =
    StateNotifierProvider<CreateMeetingNotifier, CreateMeetingState>((ref) {
      return CreateMeetingNotifier();
    });
