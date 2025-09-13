import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/provider/chat_provider.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/widget/room_tile.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';

class RoomListScreen extends ConsumerWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomsAsync = ref.watch(roomListNotifierProvider);

    Scaffold(
      appBar: SharedAppBar(showBackButton: true, title: const Text('Soulfit')),
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [Tab(text: '진행 중'), Tab(text: '종료')]),
        ),
        body: roomsAsync.when(
          data:
              (model) => TabBarView(
                children: [
                  _RoomListView(rooms: model.activeRooms),
                  _RoomListView(rooms: model.endedRooms),
                ],
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (e, _) => Center(
                child: TextButton(
                  onPressed:
                      () =>
                          ref.read(roomListNotifierProvider.notifier).refresh(),
                  child: Text('오류: $e  •  다시 시도'),
                ),
              ),
        ),
      ),
    );
  }
}

class _RoomListView extends StatelessWidget {
  final List rooms;
  const _RoomListView({required this.rooms, super.key});

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return const Center(child: Text('채팅이 없습니다.'));
    }
    return ListView.separated(
      itemBuilder: (_, i) => RoomTile(room: rooms[i]),
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemCount: rooms.length,
    );
  }
}
