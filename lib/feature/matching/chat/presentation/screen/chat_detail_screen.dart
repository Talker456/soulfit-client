import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/provider/chat_provider.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/state/chat_state.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/widget/message_bubble.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/widget/message_input_field.dart';

class DummyChatDetailScreen extends ConsumerWidget {
  final String chatRoomId;
  final String opponentNickname;
  // A hardcoded user ID for demonstration purposes
  final String myUserId = 'my_id';

  const DummyChatDetailScreen({
    super.key,
    required this.chatRoomId,
    required this.opponentNickname,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatNotifierProvider(chatRoomId));
    final chatNotifier = ref.read(chatNotifierProvider(chatRoomId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(opponentNickname),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: switch (chatState) {
              ChatInitial() || ChatLoading() => const Center(child: CircularProgressIndicator()),
              ChatError(:final message) => Center(child: Text(message)),
              ChatLoaded(:final messages) => ListView.builder(
                  itemCount: messages.length,
                  reverse: true, // To show latest messages at the bottom
                  itemBuilder: (context, index) {
                    final reversedIndex = messages.length - 1 - index;
                    final message = messages[reversedIndex];
                    final isMe = message.senderId == myUserId;
                    return MessageBubble(message: message, isMe: isMe);
                  },
                ),
            },
          ),
          MessageInputField(
            onSendPressed: (text) {
              chatNotifier.sendMessage(text);
            },
          ),
        ],
      ),
    );
  }
}
