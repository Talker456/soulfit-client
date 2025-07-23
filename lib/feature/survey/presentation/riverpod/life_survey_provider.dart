// lib/feature/survey/presentation/riverpod/life_survey_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

final lifeSurveyIndexProvider = StateProvider<int>((ref) => 0);

final lifeSurveyAnswersProvider = StateProvider<List<int>>((ref) => []);
