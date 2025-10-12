import '../repositories/past_activity_repository.dart';
import '../entities/ai_summary.dart';

// AI 요약 정보 조회 UseCase
class GetAiSummaryUseCase {
  final PastActivityRepository repository;

  GetAiSummaryUseCase({required this.repository});

  Future<AiSummary> call() async {
    return await repository.getAiSummary();
  }
}
