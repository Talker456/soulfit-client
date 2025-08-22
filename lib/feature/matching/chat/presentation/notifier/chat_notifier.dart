import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/get_messages.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/listen_to_messages.dart';
import 'package:soulfit_client/feature/matching/chat/domain/usecase/send_message.dart';

import '../state/chat_state.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final GetMessages _getMessages;
  final SendMessage _sendMessage;
  final ListenToMessages _listenToMessages;
  final String chatRoomId;
  StreamSubscription? _messageSubscription;

  ChatNotifier({
    required GetMessages getMessages,
    required SendMessage sendMessage,
    required ListenToMessages listenToMessages,
    required this.chatRoomId,
  })  : _getMessages = getMessages,
        _sendMessage = sendMessage,
        _listenToMessages = listenToMessages,
        super(ChatInitial()) {
    loadMessages();
    _listenForMessages();
  }

  Future<void> loadMessages() async {
    state = ChatLoading();
    try {
      final messages = await _getMessages(chatRoomId: chatRoomId);
      state = ChatLoaded(messages);
    } catch (e) {
      state = ChatError('Failed to load messages: $e');
    }
  }

  Future<void> sendMessage(String text) async {
    try {
      await _sendMessage(chatRoomId: chatRoomId, text: text);
      // Don't manually add the message to the state.
      // Rely on the stream to deliver the new message for a single source of truth.
    } catch (e) {
      // Optionally, handle send errors, e.g., show a temporary error state
      print('Failed to send message: $e');
    }
  }

  void _listenForMessages() {
    _messageSubscription = _listenToMessages(chatRoomId: chatRoomId).listen(
      (newMessage) {
        if (state is ChatLoaded) {
          final currentState = state as ChatLoaded;
          // Avoid adding duplicate messages if the stream is slow
          if (!currentState.messages.any((msg) => msg.id == newMessage.id)) {
            state = ChatLoaded([...currentState.messages, newMessage]);
          }
        }
      },
      onError: (error) {
        // Handle stream errors
        print('Error listening to messages: $error');
        state = ChatError('Connection lost.');
      },
    );
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
    super.dispose();
  }
}
