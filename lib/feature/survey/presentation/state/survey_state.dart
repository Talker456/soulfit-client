import 'package:equatable/equatable.dart';

import '../../domain/entity/survey.dart';

class SurveyState extends Equatable {
  final bool isLoading;
  final Survey? survey;
  final Object? error;
  final bool isSubmitted;

  const SurveyState({
    this.isLoading = false,
    this.survey,
    this.error,
    this.isSubmitted = false,
  });

  SurveyState copyWith({
    bool? isLoading,
    Survey? survey,
    Object? error,
    bool? isSubmitted,
  }) {
    return SurveyState(
      isLoading: isLoading ?? this.isLoading,
      survey: survey ?? this.survey,
      error: error ?? this.error,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [isLoading, survey, error, isSubmitted];
}
