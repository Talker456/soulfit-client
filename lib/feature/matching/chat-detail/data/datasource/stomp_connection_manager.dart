
import 'dart:async';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:soulfit_client/config/di/provider.dart';

class StompConnectionManager {
  StompClient? _stompClient;
  final String _token;
  final String _roomId;
  bool _isConnected = false;
  Completer<StompClient> _connectionCompleter = Completer<StompClient>();

  StompConnectionManager(this._token, this._roomId) {
    _connect();
  }

  Future<StompClient> getClient() {
    if (_isConnected && _stompClient != null) {
      return Future.value(_stompClient);
    }
    return _connectionCompleter.future;
  }

  void _connect() {
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://$BASE_URL:8080/ws',
        onConnect: (StompFrame frame) {
          _isConnected = true;
          if (!_connectionCompleter.isCompleted) {
            _connectionCompleter.complete(_stompClient);
          }
          print('✅ [StompConnectionManager] WebSocket connected for room $_roomId');
        },
        onWebSocketError: (dynamic error) {
          print('❌ [StompConnectionManager] WebSocket Error: $error');
          if (!_connectionCompleter.isCompleted) {
            _connectionCompleter.completeError(error);
          }
        },
        stompConnectHeaders: {'Authorization': 'Bearer $_token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer $_token'},
      ),
    );
    _stompClient!.activate();
  }

  void disconnect() {
    print('➡️ [StompConnectionManager] Disconnecting from room $_roomId...');
    _stompClient?.deactivate();
    _isConnected = false;
  }
}
