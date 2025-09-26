import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entity/survey_submission.dart';
import '../provider/survey_provider.dart';
import '../state/survey_state.dart';
import '../widgets/survey_progress_bar.dart';

class LoveSurveyScreen extends ConsumerStatefulWidget {
  const LoveSurveyScreen({super.key});

  @override
  ConsumerState<LoveSurveyScreen> createState() => _LoveSurveyScreenState();
}

class _LoveSurveyScreenState extends ConsumerState<LoveSurveyScreen> {
  int _currentQuestionIndex = 0;
  final Map<int, int> _answers = {}; // questionId -> selectedChoiceId

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // TYPE_B for Love Survey
      ref.read(surveyNotifierProvider.notifier).startSurvey('TYPE_B');
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

    ref.listen<bool>(surveyNotifierProvider.select((state) => state.isSubmitted), (previous, next) {
      if (next) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('검사 완료!'),
            content: const Text('연애 가치관 검사가 완료되었습니다.'),
            actions: [
              TextButton(
                onPressed: () => context.go('/community'),
                child: const Text('홈으로'),
              ),
            ],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('연애 가치관 검사'),
        backgroundColor: Colors.pinkAccent.shade100,
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
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _answers[question.id] == choice.id
                            ? Colors.pink
                            : Colors.pink.shade100,
                        foregroundColor: _answers[question.id] == choice.id
                            ? Colors.white
                            : Colors.black,
                      ),
                      onPressed: () => _selectOption(question.id, choice.id, questions.length),
                      child: Text(choice.text),
                    ),
                  );
                }),
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
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
              color: const Color(0xFFFF7DAE),
            ),
        ],
      ),
    );
  }
}