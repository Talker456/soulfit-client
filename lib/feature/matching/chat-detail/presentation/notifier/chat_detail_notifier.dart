import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_message.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_message_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_messages_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_image_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/send_text_message_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_detail_state.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';

class ChatDetailNotifier extends AutoDisposeFamilyAsyncNotifier<ChatDetailState, String> {
  late final GetMessagesUseCase _getMessagesUseCase;
  late final SendTextMessageUseCase _sendTextMessageUseCase;
  late final SendImageMessageUseCase _sendImageMessageUseCase;
  late final GetMessageStreamUseCase _getMessageStreamUseCase;

  late final String roomId;
  int _page = 0;
  static const _size = 30;
  StreamSubscription? _messageSubscription;

  @override
  Future<ChatDetailState> build(String roomId) async {
    _getMessagesUseCase = await ref.watch(getMessagesUseCaseProvider(roomId).future);
    _sendTextMessageUseCase = await ref.watch(sendTextMessageUseCaseProvider(roomId).future);
    _sendImageMessageUseCase = await ref.watch(sendImageMessageUseCaseProvider(roomId).future);
    _getMessageStreamUseCase = await ref.watch(getMessageStreamUseCaseProvider(roomId).future);

    this.roomId = roomId;

    _page = 0;
    try {
      final messages = await _getMessagesUseCase(GetMessagesParams(roomId: roomId, page: _page, size: _size));
      _listenToMessages();
      return ChatDetailLoaded(messages: messages.reversed.toList(), hasReachedMax: messages.length < _size);
    } catch (e, stackTrace) {
      print('##### Chat Detail Error in build: $e');
      print('##### Stack Trace in build: $stackTrace');
      return ChatDetailError('메시지를 불러오는 데 실패했습니다.');
    }
  }

  void addMessage(ChatMessage message) {
    if (state.value is ChatDetailLoaded) {
      final currentState = state.value as ChatDetailLoaded;
      if (currentState.messages.any((m) => m.id == message.id)) return;
      state = AsyncData(currentState.copyWith(messages: [...currentState.messages, message]));
    }
  }

  Future<void> fetchInitialMessages() async {
    _page = 0;
    state = const AsyncLoading();
    try {
      final messages = await _getMessagesUseCase(GetMessagesParams(roomId: roomId, page: _page, size: _size));
      state = AsyncData(ChatDetailLoaded(messages: messages.reversed.toList(), hasReachedMax: messages.length < _size));
    } catch (e, stackTrace) {
      print('##### Chat Detail Error: $e');
      print('##### Stack Trace: $stackTrace');
      state = AsyncError(ChatDetailError('메시지를 불러오는 데 실패했습니다.'), stackTrace);
    }
  }

  Future<void> fetchOlderMessages() async {
    if (state.value is! ChatDetailLoaded || (state.value as ChatDetailLoaded).hasReachedMax) return;

    final currentState = state.value as ChatDetailLoaded;
    _page++;
    try {
      final olderMessages = await _getMessagesUseCase(GetMessagesParams(roomId: roomId, page: _page, size: _size));
      state = AsyncData(currentState.copyWith(
        messages: [...olderMessages.reversed, ...currentState.messages],
        hasReachedMax: olderMessages.length < _size,
      ));
    } catch (e) {
      _page--;
    }
  }

  void _listenToMessages() {
    _messageSubscription = _getMessageStreamUseCase(GetMessageStreamParams(roomId: roomId)).listen(
      (message) {
        addMessage(message);
      },
      onError: (error) {
        print('##### Message Stream Error: $error');
      },
    );
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
    } catch (e) {
      print('##### Failed to send image: $e');
    }
  }

  @override
  void dispose() {
    _messageSubscription?.cancel();
  }
}
