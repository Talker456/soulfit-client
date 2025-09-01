import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/connect_to_chat_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/disconnect_from_chat_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_messages_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_image_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_text_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_detail_state.dart';

class ChatDetailNotifier extends StateNotifier<ChatDetailState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final SendTextMessageUseCase _sendTextMessageUseCase;
  final SendImageMessageUseCase _sendImageMessageUseCase;
  final ConnectToChatUseCase _connectToChatUseCase;
  final DisconnectFromChatUseCase _disconnectFromChatUseCase;

  final String roomId;
  int _page = 0;
  static const _size = 30; // 한 번에 불러올 메시지 수

  ChatDetailNotifier({
    required GetMessagesUseCase getMessagesUseCase,
    required SendTextMessageUseCase sendTextMessageUseCase,
    required SendImageMessageUseCase sendImageMessageUseCase,
    required ConnectToChatUseCase connectToChatUseCase,
    required DisconnectFromChatUseCase disconnectFromChatUseCase,
    required this.roomId,
  })  : _getMessagesUseCase = getMessagesUseCase,
        _sendTextMessageUseCase = sendTextMessageUseCase,
        _sendImageMessageUseCase = sendImageMessageUseCase,
        _connectToChatUseCase = connectToChatUseCase,
        _disconnectFromChatUseCase = disconnectFromChatUseCase,
        super(ChatDetailLoading()) {
    _init();
  }

  Future<void> _init() async {
    await fetchInitialMessages();
    _connectToChat();
  }

  Future<void> fetchInitialMessages() async {
    _page = 0;
    state = ChatDetailLoading();
    try {
      final messages = await _getMessagesUseCase(GetMessagesParams(roomId: roomId, page: _page, size: _size));
      state = ChatDetailLoaded(messages: messages.reversed.toList(), hasReachedMax: messages.length < _size);
    } catch (e, stackTrace) {
      print('##### Chat Detail Error: $e');
      print('##### Stack Trace: $stackTrace');
      state = const ChatDetailError('메시지를 불러오는 데 실패했습니다.');
    }
  }

  Future<void> fetchOlderMessages() async {
    if (state is! ChatDetailLoaded || (state as ChatDetailLoaded).hasReachedMax) return;

    final currentState = state as ChatDetailLoaded;
    _page++;
    try {
      final olderMessages = await _getMessagesUseCase(GetMessagesParams(roomId: roomId, page: _page, size: _size));
      state = currentState.copyWith(
        messages: [...olderMessages.reversed, ...currentState.messages],
        hasReachedMax: olderMessages.length < _size,
      );
    } catch (e) {
      _page--; // 에러 발생 시 페이지 원상복구
    }
  }

  void _connectToChat() {
    _connectToChatUseCase(ConnectToChatParams(
      roomId: roomId,
      onMessageReceived: (message) {
        if (state is ChatDetailLoaded) {
          final currentState = state as ChatDetailLoaded;
          state = currentState.copyWith(messages: [...currentState.messages, message]);
        }
      },
    ));
  }

  void sendTextMessage({required String messageText, required String sender}) {
    _sendTextMessageUseCase(SendTextMessageParams(
      roomId: roomId,
      messageText: messageText,
      sender: sender,
    ));
  }

  Future<void> sendImageMessage(File image) async {
    try {
      await _sendImageMessageUseCase(SendImageMessageParams(roomId: roomId, image: image));
      // 성공 시 WebSocket을 통해 메시지가 수신되므로 별도 처리가 필요 없을 수 있습니다.
    } catch (e) {
      print('##### Failed to send image: $e');
      // UI에 이미지 전송 실패 피드백을 줄 수 있습니다.
    }
  }

  @override
  void dispose() {
    _disconnectFromChatUseCase();
    super.dispose();
  }
}
