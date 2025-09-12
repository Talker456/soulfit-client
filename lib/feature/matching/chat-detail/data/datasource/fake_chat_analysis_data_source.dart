import 'dart:async';
import 'dart:math';
import '../../domain/entity/chat_analysis.dart';

class FakeChatAnalysisDataSource {
  final _controller = StreamController<ChatAnalysis>.broadcast(); // Use broadcast for multiple listeners if needed
  Stream<ChatAnalysis> get analysisStream => _controller.stream;

  bool get isClosed => _controller.isClosed;

  FakeChatAnalysisDataSource() {
    print("✅ [FakeDataSource] New instance created.");
  }

  // 새로운 메시지가 들어왔다고 가정하고 호출되는 메서드
  void simulateAnalysis(String message) {
    print("➡️ [FakeDataSource] simulateAnalysis called. Is controller closed? ${_controller.isClosed}");
    // 1초 후 가상 분석 결과를 생성하여 스트림에 추가
    Future.delayed(const Duration(seconds: 1), () {
      if (_controller.isClosed) return;

      final random = Random();
      final keywords = message.split(' ').where((word) => word.length > 1).take(2).toList();

      final analysis = ChatAnalysis(
        positiveScore: random.nextDouble() * 0.8 + 0.1, // 0.1 ~ 0.9
        negativeScore: random.nextDouble() * 0.2,      // 0.0 ~ 0.2
        mood: ['UPBEAT', 'CALM', 'NEUTRAL'][random.nextInt(3)],
        keywords: ['#가상분석', ...keywords],
      );
      _controller.add(analysis);
    });
  }

  void dispose() {
    print("➡️ [FakeDataSource] dispose called. Closing controller.");
    _controller.close();
  }
}
