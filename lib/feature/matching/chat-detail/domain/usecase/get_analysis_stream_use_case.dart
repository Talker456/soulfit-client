import 'package:equatable/equatable.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_analysis.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/repository/chat_detail_repository.dart';

class GetAnalysisStreamUseCase {
  final ChatDetailRepository repository;

  GetAnalysisStreamUseCase(this.repository);

  Stream<ChatAnalysis> call(GetAnalysisStreamParams params) {
    return repository.getAnalysisStream(params.roomId);
  }
}

class GetAnalysisStreamParams extends Equatable {
  final String roomId;

  const GetAnalysisStreamParams({required this.roomId});

  @override
  List<Object?> get props => [roomId];
}
