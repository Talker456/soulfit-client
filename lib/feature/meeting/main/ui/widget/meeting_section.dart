import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/meeting_summary.dart';
import '../state/meeting_list_state.dart';
import '../widget/meeting_card.dart';

class MeetingSection extends ConsumerWidget {
  final String title;
  final StateNotifierProvider provider;

  const MeetingSection({
    super.key,
    required this.title,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: switch (state) {
            MeetingListLoading() => const Center(child: CircularProgressIndicator()),
            MeetingListError(:final message) => Center(child: Text('오류: $message')),
            MeetingListLoaded(:final meetings) => ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: meetings.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final meeting = meetings[index];
                  return MeetingCard(meeting: meeting);
                },
              ),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ),
      ],
    );
  }
}
