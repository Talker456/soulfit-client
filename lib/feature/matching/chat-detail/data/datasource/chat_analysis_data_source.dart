import 'dart:async';
import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_analysis_model.dart';

import 'package:soulfit_client/feature/matching/chat-detail/data/model/chat_analysis_model.dart';

/// 실시간 대화 분석 데이터 소스의 역할을 정의하는 인터페이스
abstract class ChatAnalysisDataSource {
  /// 외부(Repository)에서 구독할 분석 결과 스트림
  Stream<ChatAnalysisModel> get analysisStream;
}
