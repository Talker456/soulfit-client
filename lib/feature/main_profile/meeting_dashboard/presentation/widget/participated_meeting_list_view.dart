import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/domain/entity/paginated_meetings.dart';
import 'package:soulfit_client/feature/main_profile/meeting_dashboard/presentation/provider/meeting_dashboard_provider.dart';

import '../state/meeting_dashboard_state.dart';

class ParticipatedMeetingListView extends ConsumerStatefulWidget {
  final PaginatedMeetings paginatedMeetings;

  const ParticipatedMeetingListView({super.key, required this.paginatedMeetings});

  @override
  ConsumerState<ParticipatedMeetingListView> createState() => _ParticipatedMeetingListViewState();
}

class _ParticipatedMeetingListViewState extends ConsumerState<ParticipatedMeetingListView> {
  final _scrollController = ScrollController();

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
    if (_isBottom) {
      ref.read(meetingDashboardNotifierProvider.notifier).loadMoreParticipatedMeetings();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final meetings = widget.paginatedMeetings.content;
    final hasMore = ref.watch(meetingDashboardNotifierProvider.select((state) =>
        state is MeetingDashboardLoaded ? state.hasMore : false));

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // This should be handled by the parent scroll view
      itemCount: meetings.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= meetings.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final meeting = meetings[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            title: Text(meeting.title, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${meeting.category} / ${meeting.city}'),
            trailing: Text(meeting.status, style: const TextStyle(color: Colors.grey)),
            onTap: () {
              // TODO: Navigate to meeting detail screen
            },
          ),
        );
      },
    );
  }
}
