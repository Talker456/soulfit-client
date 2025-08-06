import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:soulfit_client/config/router/app_router.dart';

import '../provider/meeting_list_providers.dart';
import '../state/meeting_list_state.dart';
import '../notifier/meeting_list_notifier.dart';
import '../../../../../core/ui/widget/shared_app_bar.dart';
import '../widget/meeting_filter_widgets.dart';

class MeetingListScreen extends ConsumerStatefulWidget {
  final String listType;
  const MeetingListScreen({super.key, required this.listType});

  @override
  ConsumerState<MeetingListScreen> createState() => _MeetingListScreenState();
}

class _MeetingListScreenState extends ConsumerState<MeetingListScreen> {
  final ScrollController _scrollController = ScrollController();

  StateNotifierProvider<MeetingListNotifier, MeetingListState> _getProvider(String listType) {
    switch (listType) {
      case 'aiRecommended':
        return aiRecommendedMeetingsProvider;
      case 'popular':
        return popularMeetingsProvider;
      case 'recentlyCreated':
        return recentlyCreatedMeetingsProvider;
      case 'userRecentJoined':
        return userRecentJoinedMeetingsProvider;
      default:
        throw Exception('Unknown list type: $listType');
    }
  }

  String get _screenTitle {
    switch (widget.listType) {
      case 'aiRecommended':
        return 'AI 맞춤 추천 모임';
      case 'popular':
        return '인기 모임';
      case 'recentlyCreated':
        return '최근 개설된 모임';
      case 'userRecentJoined':
        return '최근 참여한 모임';
      default:
        return '모임 목록';
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      ref.read(_getProvider(widget.listType).notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_getProvider(widget.listType));
    final currencyFormat = NumberFormat.currency(locale: 'ko_KR', symbol: '');

    return Scaffold(
      appBar: const SharedAppBar(
        showBackButton: true,
        actions: [
          Icon(Icons.history, size: 20),
          SizedBox(width: 12),
          Icon(Icons.send, size: 20),
          SizedBox(width: 12),
          Icon(Icons.search, size: 20),
        ],
      ),
      body: switch (state) {
        MeetingListError(:final message) => Center(child: Text('오류: $message')),
        MeetingListInitial() || MeetingListLoading() => const Center(child: CircularProgressIndicator()),
        MeetingListLoaded(:final meetings, :final hasNext, :final recommendationTags) =>
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _screenTitle,
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                    ),
                  ),
                ),
                if (widget.listType == 'aiRecommended' &&
                    recommendationTags.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '✨ 이런 이유로 추천했어요.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: recommendationTags
                                .map((tag) =>
                                Chip(
                                  label: Text(tag),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: const BorderSide(color: Colors.grey),
                                  ),
                                ))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (widget.listType != 'aiRecommended')
                  SliverToBoxAdapter(
                    child: MeetingFilterBar(listType: widget.listType),
                  ),
                if (meetings.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('${_screenTitle}이(가) 없습니다.')),
                  )
                else
                  SliverList.builder(
                    itemCount: meetings.length + (hasNext ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == meetings.length) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final meeting = meetings[index];
                      // TODO: Implement popularity rank display for 'popular' list type
                      // if (widget.listType == 'popular') {
                      //   // Display rank: index + 1
                      // }
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                              color: Colors.green.shade300, width: 1),
                        ),
                        clipBehavior: Clip.antiAlias,
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            context.push(AppRoutes.meetingDetail.replaceFirst(
                                ':meetingId', meeting.meetingId));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    meeting.thumbnailUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        meeting.title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '${currencyFormat.format(
                                            meeting.price)}원',
                                        style: const TextStyle(fontSize: 14,
                                            color: Colors.black87),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${meeting
                                            .currentParticipants} / ${meeting
                                            .maxParticipants}명',
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
      }
    );
  }
}

