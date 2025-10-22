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
        personality: Personality(
          userA: ['분석적', '신중함'],
          userB: ['외향적', '낙천적'],
        ),
        empathy: Empathy(
          userA: '높음',
          userB: '보통',
        ),
        responseSpeed: ResponseSpeed(
          userA: '빠름',
          userB: '보통',
        ),
        questionFrequency: QuestionFrequency(
          userA: '많음',
          userB: '적음',
        ),
        interestLevel: '높음',
        vibe: Vibe(
          keywords: ['#가상분석', '#페이크데이터'],
          summary: '가상으로 생성된 대화 분석 결과입니다.',
        ),
      );
      _controller.add(analysis);
    });
  }

  void dispose() {
    print("➡️ [FakeDataSource] dispose called. Closing controller.");
    _controller.close();
  }
}
