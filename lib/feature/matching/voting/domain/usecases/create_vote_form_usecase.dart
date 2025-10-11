import '../entities/vote_form.dart';
import '../repositories/voting_repository.dart';

/// 투표 폼 생성 UseCase
class CreateVoteFormUseCase {
  final VotingRepository repository;

  CreateVoteFormUseCase(this.repository);

  /// 투표 폼 생성 실행
  /// [imageUrl] 사용자의 프로필 이미지 URL
  /// [title] 투표 제목
  /// Returns: 생성된 투표 폼
  Future<VoteForm> execute({
    required String imageUrl,
    required String title,
  }) async {
    return await repository.createVoteForm(
      imageUrl: imageUrl,
      title: title,
    );
  }
}
