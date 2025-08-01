import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:soulfit_client/config/router/app_router.dart';

import '../provider/meeting_list_providers.dart';
import '../state/meeting_list_state.dart';
import '../widget/shared_app_bar.dart';

class AiMeetingListScreen extends ConsumerStatefulWidget {
  const AiMeetingListScreen({super.key});

  @override
  ConsumerState<AiMeetingListScreen> createState() => _AiMeetingListScreenState();
}

class _AiMeetingListScreenState extends ConsumerState<AiMeetingListScreen> {
  final ScrollController _scrollController = ScrollController();

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
      ref.read(aiRecommendedMeetingsProvider.notifier).fetchNextPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiRecommendedMeetingsProvider);
    final currencyFormat = NumberFormat.currency(locale: 'ko_KR', symbol: '');

    return Scaffold(
      appBar: const SharedAppBar(showBackButton: true),
      body: switch (state) {
        MeetingListLoaded(meetings: final m, recommendationTags: final t) when m.isEmpty =>
          const Center(child: Text('추천 모임이 없습니다.')),

        MeetingListLoaded(:final meetings, :final hasNext, :final recommendationTags) =>
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'AI 맞춤 추천 모임',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              if (recommendationTags.isNotEmpty)
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
                              .map((tag) => Chip(
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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.green.shade300, width: 1),
                    ),
                    clipBehavior: Clip.antiAlias,
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        context.push(AppRoutes.meetingDetail.replaceFirst(':meetingId', meeting.meetingId));
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meeting.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${currencyFormat.format(meeting.price)}원',
                                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${meeting.currentParticipants} / ${meeting.maxParticipants}명',
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
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

        MeetingListInitial() || MeetingListLoading() =>
          const Center(child: CircularProgressIndicator()),

        MeetingListError(:final message) => Center(child: Text('오류: $message')),
        
        _ => const SizedBox.shrink(),
      },
    );
  }
}

