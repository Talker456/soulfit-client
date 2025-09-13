
import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_message_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/stomp_connection_manager.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_message_model.dart';

class ChatMessageDataSourceImpl implements ChatMessageDataSource {
  final StompConnectionManager _connectionManager;
  final String _roomId;
  final _messageController = StreamController<ChatMessageModel>.broadcast();
  Function? _messageSubscription;

  ChatMessageDataSourceImpl(this._connectionManager, this._roomId) {
    _subscribeToMessages();
  }

  @override
  Stream<ChatMessageModel> get messageStream => _messageController.stream;

  void _subscribeToMessages() async {
    try {
      final stompClient = await _connectionManager.getClient();
      _messageSubscription = stompClient.subscribe(
        destination: '/topic/room/$_roomId',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            try {
              final Map<String, dynamic> data = jsonDecode(frame.body!);
              final message = ChatMessageModel.fromJson(data);
              _messageController.add(message);
            } catch (e) {
              print('❌ [ChatMessageDataSource] Message data parsing error: $e');
              _messageController.addError(e);
            }
          }
        },
      );
      print('✅ [ChatMessageDataSource] Subscribed to message topic for room $_roomId');
    } catch (e) {
      print('❌ [ChatMessageDataSource] Failed to subscribe to messages: $e');
      _messageController.addError(e);
    }
  }

  @override
  void sendMessage({required String roomId, required String messageText, required String sender}) async {
    try {
      final stompClient = await _connectionManager.getClient();
      stompClient.send(
        destination: '/app/chat/send',
        body: jsonEncode({
          'roomId': int.tryParse(roomId) ?? 0,
          'sender': sender,
          'message': messageText,
        }),
      );
    } catch (e) {
      print('❌ [ChatMessageDataSource] Failed to send message: $e');
    }
  }

  void dispose() {
    print('➡️ [ChatMessageDataSource] Disposing for room $_roomId...');
    _messageSubscription?.call();
    _messageController.close();
  }
}
