import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifier/meeting_post_notifier.dart';
import '../state/meeting_post_state.dart';

final meetingPostProvider =
    StateNotifierProvider<MeetingPostNotifier, MeetingPostState>((ref) {
      return MeetingPostNotifier();
    });
