import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_analysis_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_analysis_state.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';

class ChatAnalysisNotifier extends AutoDisposeFamilyAsyncNotifier<ChatAnalysisState, String> {
  late final GetAnalysisStreamUseCase _getAnalysisStreamUseCase;
  late final String roomId;
  StreamSubscription? _analysisSubscription;

  @override
  Future<ChatAnalysisState> build(String roomId) async {
    // roomId is now a parameter, no need for this.arg

    _getAnalysisStreamUseCase = await ref.watch(getAnalysisStreamUseCaseProvider(roomId).future);

    // Assign to class member
    this.roomId = roomId;

    print("✅ [AnalysisNotifier] Created for room: $roomId");
    _listenToAnalysis();

    return ChatAnalysisInitial();
  }

  void _listenToAnalysis() {
    print('➡️ [AnalysisNotifier] Subscribing to analysis stream...');
    state = const AsyncLoading();
    _analysisSubscription = _getAnalysisStreamUseCase(GetAnalysisStreamParams(roomId: roomId)).listen(
      (analysis) {
        print('✅ [AnalysisNotifier] Received new analysis from stream. State will be updated.');
        state = AsyncData(ChatAnalysisLoaded(analysis));
      },
      onError: (error, stackTrace) {
        print('❌ [AnalysisNotifier] Stream error: $error');
        state = AsyncError(ChatAnalysisError('Failed to get chat analysis: $error'), stackTrace);
      },
    );
  }

  @override
  void dispose() {
    print("➡️ [AnalysisNotifier] dispose called for room: $roomId");
    _analysisSubscription?.cancel();
  }
}
