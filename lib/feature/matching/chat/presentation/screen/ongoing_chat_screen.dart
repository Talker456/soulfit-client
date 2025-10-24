import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/config/router/app_router.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/state/ongoing_chat_state.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/widget/ongoing_chat_card.dart';

import '../provider/ongoing_chat_provider.dart';

class OngoingChatScreen extends ConsumerStatefulWidget {
  const OngoingChatScreen({super.key});

  @override
  ConsumerState<OngoingChatScreen> createState() => _OngoingChatScreenState();
}

class _OngoingChatScreenState extends ConsumerState<OngoingChatScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      ref.read(ongoingChatNotifierProvider.notifier).fetchMoreChats();
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
    final state = ref.watch(ongoingChatNotifierProvider);

    return Scaffold(
      appBar: SharedAppBar(
        title: const Text('채팅'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(ongoingChatNotifierProvider.notifier).fetchOngoingChats();
            },
          ),
        ],
      ),
      body: switch (state) {
        OngoingChatLoading() => const Center(child: CircularProgressIndicator()),
        OngoingChatError(:final message) => Center(child: Text(message)),
        OngoingChatLoaded(:final chats, :final hasReachedMax) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    return OngoingChatCard(
                      chat: chat,
                      onTap: () async {
                        print('##### [OngoingChatScreen] Navigating to chat room: ${chat.roomId}');
                        await context.push(
                          '${AppRoutes.chatDetail}/${chat.roomId}/${chat.opponentNickname}/${chat.opponentId}',
                        );
                        print('##### [OngoingChatScreen] Returned from chat room: ${chat.roomId}. Refreshing chat list.');
                        ref.read(ongoingChatNotifierProvider.notifier).fetchOngoingChats();
                      },
                    );
                  },
                ),
              ),
              if (!hasReachedMax)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
      },
    );
  }
}