import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/meeting_summary.dart';
import '../state/meeting_list_state.dart';

class MeetingListNotifier extends StateNotifier<MeetingListState> {
  final dynamic useCase;
  int _page = 1;
  static const int _size = 10;

  MeetingListNotifier({required this.useCase}) : super(MeetingListInitial()) {
    fetchFirstPage();
  }

  Future<void> fetchFirstPage() async {
    _page = 1;
    print('[Notifier] Fetching first page (page: $_page, size: ${_size})');
    state = MeetingListLoading();
    try {
      final meetings = await useCase.execute(page: _page, size: _size) as List<MeetingSummary>;
      final hasNext = meetings.length == _size;
      state = MeetingListLoaded(meetings, hasNext: hasNext);
      print('[Notifier] First page loaded. Item count: ${meetings.length}, Has next: $hasNext');
    } catch (e) {
      state = MeetingListError(e.toString());
      print('[Notifier] Error fetching first page: $e');
    }
  }

  Future<void> fetchNextPage() async {
    if (state is MeetingListLoaded && (state as MeetingListLoaded).hasNext) {
      final loadedState = state as MeetingListLoaded;
      _page++;
      print('[Notifier] Fetching next page (page: $_page, size: ${_size})');
      try {
        final newMeetings = await useCase.execute(page: _page, size: _size) as List<MeetingSummary>;
        final hasNext = newMeetings.length == _size;
        final updatedMeetings = [...loadedState.meetings, ...newMeetings];
        state = MeetingListLoaded(
          updatedMeetings,
          hasNext: hasNext,
        );
        print('[Notifier] Next page loaded. Total items: ${updatedMeetings.length}, Has next: $hasNext');
      } catch (e) {
        print('[Notifier] Error fetching next page: $e');
        state = MeetingListError(e.toString());
      }
    }
  }
}
