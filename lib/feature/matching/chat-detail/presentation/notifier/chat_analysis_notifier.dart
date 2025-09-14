import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_room_params.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/usecase/get_analysis_stream_use_case.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_analysis_state.dart';

class ChatAnalysisNotifier extends FamilyAsyncNotifier<ChatAnalysisState, ChatRoomParams> {
  late final GetAnalysisStreamUseCase _getAnalysisStreamUseCase;
  late final String roomId;
  StreamSubscription? _analysisSubscription;

  @override
  Future<ChatAnalysisState> build(ChatRoomParams arg) async {
    roomId = arg.roomId;

    _getAnalysisStreamUseCase = await ref.watch(getAnalysisStreamUseCaseProvider(arg).future);

    ref.onDispose(() {
      print("➡️ [AnalysisNotifier] dispose called for room: $roomId");
      _analysisSubscription?.cancel();
    });

    print("✅ [AnalysisNotifier] Created for room: $roomId, user: ${arg.userId}");
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
}
