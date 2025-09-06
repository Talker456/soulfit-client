import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/domain/entity/message.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/provider/chat_provider.dart';
import 'package:soulfit_client/feature/meeting/meeting_chat/ui/widget/message_bubble.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  final String roomId;
  final String title;
  const ChatRoomScreen({super.key, required this.roomId, required this.title});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final _tc = TextEditingController();
  final _scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    final stateAsync = ref.watch(chatRoomNotifierProvider(widget.roomId));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline),
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed('/participants', arguments: widget.roomId);
            },
          ),
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          PopupMenuButton(
            itemBuilder:
                (_) => const [PopupMenuItem(value: 'menu', child: Text('메뉴'))],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: stateAsync.when(
              data: (s) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scroll.hasClients) {
                    _scroll.jumpTo(_scroll.position.maxScrollExtent);
                  }
                });
                return ListView.builder(
                  controller: _scroll,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 10,
                  ),
                  itemCount: s.messages.length,
                  itemBuilder: (_, i) {
                    final m = s.messages[i];
                    final isMine = m.sender == SenderType.me;
                    return MessageBubble(message: m, isMine: isMine);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('오류: $e')),
            ),
          ),
          SafeArea(
            top: false,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.image_outlined),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: TextField(
                      controller: _tc,
                      decoration: const InputDecoration(
                        hintText: '메시지를 입력하세요 ...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Consumer(
                  builder: (_, ref, __) {
                    final sending = stateAsync.asData?.value.sending ?? false;
                    return IconButton(
                      onPressed: sending ? null : _send,
                      icon: const Icon(Icons.send),
                      color: Colors.green,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _send() {
    final text = _tc.text.trim();
    if (text.isEmpty) return;
    ref.read(chatRoomNotifierProvider(widget.roomId).notifier).send(text);
    _tc.clear();
  }
}
