import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/survey_submission.dart';
import '../../domain/usecase/start_survey_usecase.dart';
import '../../domain/usecase/submit_survey_usecase.dart';
import '../state/survey_state.dart';

class SurveyNotifier extends StateNotifier<SurveyState> {
  final StartSurveyUseCase _startSurveyUseCase;
  final SubmitSurveyUseCase _submitSurveyUseCase;

  SurveyNotifier({
    required StartSurveyUseCase startSurveyUseCase,
    required SubmitSurveyUseCase submitSurveyUseCase,
  })  : _startSurveyUseCase = startSurveyUseCase,
        _submitSurveyUseCase = submitSurveyUseCase,
        super(const SurveyState());

  Future<void> startSurvey(String testType) async {
    // Reset state for a new survey
    state = const SurveyState(isLoading: true);
    try {
      final survey = await _startSurveyUseCase(testType);
      state = state.copyWith(isLoading: false, survey: survey);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }

  Future<void> submitSurvey(SurveySubmission submission) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _submitSurveyUseCase(submission);
      state = state.copyWith(isLoading: false, isSubmitted: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e);
    }
  }
}
