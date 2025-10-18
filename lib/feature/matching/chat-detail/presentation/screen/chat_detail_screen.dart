import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_room_params.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/read_chat_room_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_detail_state.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/widget/chat_analysis_display.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  final String roomId;
  final String opponentNickname;

  const ChatDetailScreen({
    super.key,
    required this.roomId,
    required this.opponentNickname,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

enum _InputMode { keyboard, analysis }

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final _imagePicker = ImagePicker();
  final _focusNode = FocusNode();
  var _inputMode = _InputMode.keyboard;

  // Add a member variable for params
  late final ChatRoomParams _params;

  @override
  void initState() {
    super.initState();

    // Initialize params in initState using ref.read
    // Note: This assumes user data is already available upon entering the screen.
    final myUserId = ref.read(authNotifierProvider).user?.id;
    if (myUserId == null) {
      // Handle this case appropriately, maybe pop the screen
      // For now, we'll throw an error to make it explicit.
      throw Exception("User not logged in, cannot enter chat.");
    }
    _params = ChatRoomParams(roomId: widget.roomId, userId: myUserId);

    _readChatRoom();

    _scrollController.addListener(_onScroll);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _inputMode == _InputMode.analysis) {
        setState(() {
          _inputMode = _InputMode.keyboard;
        });
      }
    });
  }

  void _readChatRoom() async {
    print('##### [ChatDetailScreen] Attempting to mark room ${widget.roomId} as read.');
    try {
      final readChatRoomUseCase = await ref.read(readChatRoomUseCaseProvider(_params).future);
      await readChatRoomUseCase(ReadChatRoomParams(roomId: widget.roomId));
      print('##### [ChatDetailScreen] Successfully marked room ${widget.roomId} as read.');
    } catch (e) {
      // Handle error appropriately
      print('##### [ChatDetailScreen] Failed to mark chat room as read: $e');
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent) {
      ref.read(chatDetailNotifierProvider(_params).notifier).fetchOlderMessages();
    }
  }

  void _sendMessage(String myUsername) {
    if (_textController.text.trim().isEmpty) return;
    ref.read(chatDetailNotifierProvider(_params).notifier).sendTextMessage(
          messageText: _textController.text,
          sender: myUsername,
        );
    _textController.clear();
  }

  Future<void> _sendImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      ref
          .read(chatDetailNotifierProvider(_params).notifier)
          .sendImageMessage(File(pickedFile.path));
    }
  }

  void _toggleInputMode() {
    setState(() {
      if (_inputMode == _InputMode.keyboard) {
        _inputMode = _InputMode.analysis;
        _focusNode.unfocus();
      } else {
        _inputMode = _InputMode.keyboard;
        _focusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final myUsername = ref.watch(authNotifierProvider).user?.username;
    final chatDetailAsync = ref.watch(chatDetailNotifierProvider(_params));

    ref.listen(chatDetailNotifierProvider(_params), (previous, next) {
      if (next.value is ChatDetailLoaded) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          }
        });
      }
    });

    if (myUsername == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: SharedAppBar(
        showBackButton: true,
        title: Text(widget.opponentNickname),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatDetailAsync.when(
              data: (state) => switch (state) {
                ChatDetailLoading() => const Center(child: CircularProgressIndicator()),
                ChatDetailError(:final message) => Center(child: Text(message)),
                ChatDetailLoaded(:final messages) => ListView.builder(
                    controller: _scrollController,
                    reverse: false,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.sender == myUsername;
                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.blue[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(message.message ?? '...'),
                        ),
                      );
                    },
                  ),
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          _buildMessageInputField(myUsername),
          _buildBottomPanel(),
        ],
      ),
    );
  }

  Widget _buildMessageInputField(String myUsername) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -1),
            blurRadius: 1,
            color: Colors.grey.withOpacity(0.1),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined),
              onPressed: _sendImage,
            ),
            IconButton(
              icon: Icon(_inputMode == _InputMode.analysis
                  ? Icons.keyboard_alt_outlined
                  : Icons.analytics_outlined),
              onPressed: _toggleInputMode,
            ),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: '메시지 입력...',
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => _sendMessage(myUsername),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _sendMessage(myUsername),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPanel() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      child: _inputMode == _InputMode.analysis
          ? Container(
              height: 280, // Typical keyboard height
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ChatAnalysisDisplay(params: _params),
            )
          : const SizedBox.shrink(),
    );
  }
}

