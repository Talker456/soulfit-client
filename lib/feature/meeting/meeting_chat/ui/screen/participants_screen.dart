import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/provider/chat_provider.dart';

class ParticipantsScreen extends ConsumerWidget {
  final String roomId;
  const ParticipantsScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateAsync = ref.watch(chatRoomNotifierProvider(roomId));
    return Scaffold(
      appBar: AppBar(title: const Text('참가자 목록')),
      body: stateAsync.when(
        data:
            (s) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, i) {
                final p = s.participants[i];
                return Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.black12,
                      radius: 24,
                    ),
                    const SizedBox(width: 12),
                    Text('(${p.nickname})'),
                  ],
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: s.participants.length,
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('오류: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref.read(chatRoomNotifierProvider(roomId).notifier).leaveRoom();
          if (context.mounted) Navigator.of(context).pop(); // 방 나가고 뒤로
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
