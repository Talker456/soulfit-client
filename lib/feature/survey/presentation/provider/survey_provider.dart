import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/survey/data/datasource/fake_survey_remote_datasource_impl.dart';

import '../../../../config/di/provider.dart';
import '../../data/datasource/survey_remote_data_source.dart';
import '../../data/datasource/survey_remote_data_source_impl.dart';
import '../../data/repository_impl/survey_repository_impl.dart';
import '../../domain/repository/survey_repository.dart';
import '../../domain/usecase/start_survey_usecase.dart';
import '../../domain/usecase/submit_survey_usecase.dart';
import '../notifier/survey_notifier.dart';
import '../state/survey_state.dart';

// --- Data Layer Providers ---

final _surveyRemoteDataSourceProvider = Provider<SurveyRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeSurveyRemoteDataSourceImpl();
  } else {
    return SurveyRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      authSource: ref.read(authLocalDataSourceProvider),
      // base: 'YOUR_BASE_URL' // Optionally override the base URL here
    );
  }
});

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  return SurveyRepositoryImpl(
    remoteDataSource: ref.watch(_surveyRemoteDataSourceProvider),
  );
});

// --- Domain Layer Providers ---

final startSurveyUseCaseProvider = Provider<StartSurveyUseCase>((ref) {
  return StartSurveyUseCase(ref.watch(surveyRepositoryProvider));
});

final submitSurveyUseCaseProvider = Provider<SubmitSurveyUseCase>((ref) {
  return SubmitSurveyUseCase(ref.watch(surveyRepositoryProvider));
});

// --- Presentation Layer Provider ---

final surveyNotifierProvider = StateNotifierProvider.autoDispose<SurveyNotifier, SurveyState>((ref) {
  return SurveyNotifier(
    startSurveyUseCase: ref.watch(startSurveyUseCaseProvider),
    submitSurveyUseCase: ref.watch(submitSurveyUseCaseProvider),
  );
});
