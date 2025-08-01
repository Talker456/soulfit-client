import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/meeting_summary.dart';
import '../../domain/usecase/get_ai_recommended_meetings_usecase.dart';
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
      if (useCase is GetAiRecommendedMeetingsUseCase) {
        final result = await useCase.execute(page: _page, size: _size) as AiRecommendationResult;
        final hasNext = result.meetings.length == _size;
        state = MeetingListLoaded(result.meetings, hasNext: hasNext, recommendationTags: result.tags);
      } else {
        final meetings = await useCase.execute(page: _page, size: _size) as List<MeetingSummary>;
        final hasNext = meetings.length == _size;
        state = MeetingListLoaded(meetings, hasNext: hasNext);
      }
      print('[Notifier] First page loaded.');
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
        if (useCase is GetAiRecommendedMeetingsUseCase) {
          final result = await useCase.execute(page: _page, size: _size) as AiRecommendationResult;
          final hasNext = result.meetings.length == _size;
          final updatedMeetings = [...loadedState.meetings, ...result.meetings];
          state = loadedState.copyWith(meetings: updatedMeetings, hasNext: hasNext);
        } else {
          final newMeetings = await useCase.execute(page: _page, size: _size) as List<MeetingSummary>;
          final hasNext = newMeetings.length == _size;
          final updatedMeetings = [...loadedState.meetings, ...newMeetings];
          state = loadedState.copyWith(meetings: updatedMeetings, hasNext: hasNext);
        }
        print('[Notifier] Next page loaded. Total items: ${(state as MeetingListLoaded).meetings.length}');
      } catch (e) {
        print('[Notifier] Error fetching next page: $e');
        state = MeetingListError(e.toString());
      }
    }
  }
}
