import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entity/survey_submission.dart';
import '../provider/survey_provider.dart';
import '../state/survey_state.dart';
import '../widgets/survey_option_button.dart';
import '../widgets/survey_progress_bar.dart';

class LifeSurveyScreen extends ConsumerStatefulWidget {
  const LifeSurveyScreen({super.key});

  @override
  ConsumerState<LifeSurveyScreen> createState() => _LifeSurveyScreenState();
}

class _LifeSurveyScreenState extends ConsumerState<LifeSurveyScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _answers = {}; // questionId -> selectedChoiceId

  @override
  void initState() {
    super.initState();
    // Use post-frame callback to avoid calling notifier during build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TYPE_A for Life Survey
      ref.read(surveyNotifierProvider.notifier).startSurvey('TYPE_A');
    });
  }

  void _selectOption(int questionId, int choiceId, int totalQuestions) {
    setState(() {
      _answers[questionId] = choiceId;
    });

    if (_currentQuestionIndex < totalQuestions - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Last question answered, submit the survey
      final surveyState = ref.read(surveyNotifierProvider);
      if (surveyState.survey != null) {
        final submission = SurveySubmission(
          sessionId: surveyState.survey!.sessionId,
          answers: _answers.entries.map((entry) {
            return Answer(questionId: entry.key, selectedChoiceId: entry.value);
          }).toList(),
        );
        ref.read(surveyNotifierProvider.notifier).submitSurvey(submission);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyNotifierProvider);

    // Listen for submission completion to show dialog
    ref.listen<bool>(surveyNotifierProvider.select((state) => state.isSubmitted), (previous, next) {
      if (next) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('검사 완료!'),
            content: const Text('인생 가치관 검사가 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  context.go('/community'); // Go to community
                },
                child: const Text('홈으로'),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('인생 가치관 검사'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: _buildBody(surveyState),
    );
  }

  Widget _buildBody(SurveyState surveyState) {
    if (surveyState.isLoading && surveyState.survey == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (surveyState.error != null) {
      return Center(child: Text('오류가 발생했습니다: ${surveyState.error}'));
    }

    if (surveyState.survey == null) {
      return const Center(child: Text('설문을 불러오지 못했습니다.'));
    }

    final questions = surveyState.survey!.questions;
    final question = questions[_currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Q${_currentQuestionIndex + 1}. ${question.content}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                ...question.choices.map((choice) {
                  return SurveyOptionButton(
                    text: choice.text,
                    isSelected: _answers[question.id] == choice.id,
                    onPressed: () => _selectOption(question.id, choice.id, questions.length),
                    selectedColor: const Color(0xFF66A825),
                    unselectedColor: Colors.grey.shade200,
                  );
                }),
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                        // Answer for the previous question is not removed to allow re-selection
                      });
                    },
                    child: const Text('← 이전으로'),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (surveyState.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            SurveyProgressBar(
              currentStep: _currentQuestionIndex,
              totalSteps: questions.length,
              color: const Color(0xFF66A825),
            ),
        ],
      ),
    );
  }
}