import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/conversation_request_provider.dart';
import '../state/sent_conversation_request_state.dart';
import '../widget/sent_conversation_request_card.dart';

class SentConversationRequestScreen extends ConsumerWidget {
  const SentConversationRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sentConversationRequestNotifierProvider);

    return Scaffold(
      body: switch (state) {
        SentConversationRequestLoading() => const Center(child: CircularProgressIndicator()),
        SentConversationRequestError(:final message) => Center(child: Text(message)),
        SentConversationRequestLoaded(:final requests) => ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: requests.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final request = requests[index];
            return SentConversationRequestCard(
              request: request,
              onViewProfile: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${request.recipientUsername}님의 프로필 보기')),
                );
              },
            );
          },
        )
      },
    );
  }
}
