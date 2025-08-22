import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/config/router/app_router.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/state/ongoing_chat_state.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/widget/ongoing_chat_card.dart';

import '../provider/ongoing_chat_provider.dart';

class OngoingChatScreen extends ConsumerWidget {
  const OngoingChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ongoingChatNotifierProvider);

    return Scaffold(
      body: switch (state) {
        OngoingChatLoading() => const Center(child: CircularProgressIndicator()),
        OngoingChatError(:final message) => Center(child: Text(message)),
        OngoingChatLoaded(:final chats) => ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return OngoingChatCard(
                chat: chat,
                onTap: () {
                  // Navigate to chat detail screen
                  context.push(
                    '${AppRoutes.chatDetail}/${chat.roomId}/${chat.opponentNickname}',
                    //${AppRoutes.meetingList}/popular'
                  );
                },
              );
            },
          ),
      },
    );
  }
}