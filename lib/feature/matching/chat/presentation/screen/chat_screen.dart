import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/screen/received_conversation_request_screen.dart';
import 'package:soulfit_client/feature/matching/chat/presentation/screen/sent_conversation_request_screen.dart';

import 'ongoing_chat_screen.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text('채팅'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: '받은 대화신청'),
              Tab(text: '보낸 대화신청'),
              Tab(text: '대화 중인 채팅'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReceivedConversationRequestScreen(),
            SentConversationRequestScreen(),
            OngoingChatScreen(),
          ],
        ),
      ),
    );
  }
}
