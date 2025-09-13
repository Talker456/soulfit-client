
import 'dart:async';
import 'dart:convert';

import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/chat_analysis_data_source.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/datasource/stomp_connection_manager.dart';
import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_analysis_model.dart';

class ChatAnalysisDataSourceImpl implements ChatAnalysisDataSource {
  final StompConnectionManager _connectionManager;
  final String _roomId;
  final _analysisController = StreamController<ChatAnalysisModel>.broadcast();
  Function? _analysisSubscription;

  ChatAnalysisDataSourceImpl(this._connectionManager, this._roomId) {
    _subscribeToAnalysis();
  }

  @override
  Stream<ChatAnalysisModel> get analysisStream => _analysisController.stream;

  void _subscribeToAnalysis() async {
    try {
      final stompClient = await _connectionManager.getClient();
      _analysisSubscription = stompClient.subscribe(
        destination: '/topic/analysis/$_roomId',
        callback: (StompFrame frame) {
          if (frame.body != null) {
            try {
              final Map<String, dynamic> data = jsonDecode(frame.body!);
              final analysis = ChatAnalysisModel.fromJson(data);
              _analysisController.add(analysis);
            } catch (e) {
              print('❌ [ChatAnalysisDataSource] Analysis data parsing error: $e');
              _analysisController.addError(e);
            }
          }
        },
      );
      print('✅ [ChatAnalysisDataSource] Subscribed to analysis topic for room $_roomId');
    } catch (e) {
      print('❌ [ChatAnalysisDataSource] Failed to subscribe to analysis: $e');
      _analysisController.addError(e);
    }
  }

  void dispose() {
    print('➡️ [ChatAnalysisDataSource] Disposing for room $_roomId...');
    _analysisSubscription?.call();
    _analysisController.close();
  }
}
