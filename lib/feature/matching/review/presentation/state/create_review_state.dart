
enum CreateReviewStatus { initial, loading, success, error, keywordsLoading, keywordsLoaded }

class CreateReviewState {
  final CreateReviewStatus status;
  final List<String> keywords;
  final String? error;

  CreateReviewState({
    this.status = CreateReviewStatus.initial,
    this.keywords = const [],
    this.error,
  });

  CreateReviewState copyWith({
    CreateReviewStatus? status,
    List<String>? keywords,
    String? error,
  }) {
    return CreateReviewState(
      status: status ?? this.status,
      keywords: keywords ?? this.keywords,
      error: error ?? this.error,
    );
  }
}
