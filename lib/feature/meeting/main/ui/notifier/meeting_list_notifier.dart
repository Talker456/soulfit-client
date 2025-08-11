import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/meeting_summary.dart';
import '../../domain/usecase/get_ai_recommended_meetings_usecase.dart';
import '../state/meeting_list_state.dart';
import '../../domain/entity/meeting_filter_params.dart';

class MeetingListNotifier extends StateNotifier<MeetingListState> {
  final dynamic useCase;
  final String? category;
  int _page = 1;
  static const int _size = 10;
  MeetingFilterParams _currentFilters = const MeetingFilterParams();

  MeetingListNotifier({required this.useCase, this.category}) : super(MeetingListInitial()) {
    // 카테고리가 있으면 필터에 바로 적용
    if (category != null) {
      _currentFilters = _currentFilters.copyWith(category: category);
    }
    fetchFirstPage();
  }

  void applyFilters(MeetingFilterParams newFilters) {
    // 카테고리 필터는 유지하면서 다른 필터들을 업데이트
    _currentFilters = newFilters.copyWith(category: category);
    fetchFirstPage(); // 필터 적용 시 첫 페이지부터 다시 로드
  }

  Future<void> fetchFirstPage() async {
    _page = 1;
    print('[Notifier] Fetching first page (page: $_page, size: ${_size}, filters: $_currentFilters)');
    state = MeetingListLoading();
    try {
      if (useCase is GetAiRecommendedMeetingsUseCase) {
        final result = await useCase.execute(page: _page, size: _size, filterParams: _currentFilters) as AiRecommendationResult;
        final hasNext = result.meetings.length == _size;
        state = MeetingListLoaded(result.meetings, hasNext: hasNext, recommendationTags: result.tags, activeFilters: _currentFilters);
      } else {
        final meetings = await useCase.execute(page: _page, size: _size, filterParams: _currentFilters) as List<MeetingSummary>;
        final hasNext = meetings.length == _size;
        state = MeetingListLoaded(meetings, hasNext: hasNext, activeFilters: _currentFilters);
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
      print('[Notifier] Fetching next page (page: $_page, size: ${_size}, filters: $_currentFilters)');
      try {
        if (useCase is GetAiRecommendedMeetingsUseCase) {
          final result = await useCase.execute(page: _page, size: _size, filterParams: _currentFilters) as AiRecommendationResult;
          final hasNext = result.meetings.length == _size;
          final updatedMeetings = [...loadedState.meetings, ...result.meetings];
          state = loadedState.copyWith(meetings: updatedMeetings, hasNext: hasNext, activeFilters: _currentFilters);
        } else {
          final newMeetings = await useCase.execute(page: _page, size: _size, filterParams: _currentFilters) as List<MeetingSummary>;
          final hasNext = newMeetings.length == _size;
          final updatedMeetings = [...loadedState.meetings, ...newMeetings];
          state = loadedState.copyWith(meetings: updatedMeetings, hasNext: hasNext, activeFilters: _currentFilters);
        }
        print('[Notifier] Next page loaded. Total items: ${(state as MeetingListLoaded).meetings.length}');
      } catch (e) {
        print('[Notifier] Error fetching next page: $e');
        state = MeetingListError(e.toString());
      }
    }
  }
}
