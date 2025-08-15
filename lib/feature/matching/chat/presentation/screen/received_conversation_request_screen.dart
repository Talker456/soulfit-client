import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/conversation_request_provider.dart';
import '../state/conversation_request_state.dart';
import '../widget/conversation_request_card.dart';

class ReceivedConversationRequestScreen extends ConsumerWidget {
  const ReceivedConversationRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(conversationRequestNotifierProvider);
    final notifier = ref.read(conversationRequestNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('받은 대화 신청'),
        centerTitle: true,
      ),
      body: switch (state) {
        ConversationRequestLoading() => const Center(child: CircularProgressIndicator()),
        ConversationRequestError(:final message) => Center(child: Text(message)),
        ConversationRequestLoaded(:final requests) => ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: requests.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final request = requests[index];
            return ConversationRequestCard(
              request: request,
              onAccept: () => notifier.accept(request.requestId),
              onReject: () => notifier.reject(request.requestId),
              onViewProfile: () {
                // 추후 상세 프로필 화면으로 라우팅 예정
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${request.username}님의 프로필 보기')),
                );
              },
            );
          },
        )
      },
    );
  }
}
