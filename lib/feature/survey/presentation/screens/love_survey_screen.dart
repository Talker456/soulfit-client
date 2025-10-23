import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entity/survey_submission.dart';
import '../provider/survey_provider.dart';
import '../state/survey_state.dart';
import '../widgets/survey_option_button.dart';
import '../widgets/survey_progress_bar.dart';
import '../widgets/survey_question_box.dart';

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
      ref.read(surveyNotifierProvider.notifier).startSurvey('TYPE_B');
    });
  }

  void _selectOption(int questionId, int choiceId, int totalQuestions) {
    setState(() {
      _answers[questionId] = choiceId;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
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
    });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('나의 연애가치관은?', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.pink),
          onPressed: () => context.pop(),
        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          SurveyQuestionBox(
            questionText: question.content,
            borderColor: Colors.pink,
            textColor: Colors.pink,
          ),
          const SizedBox(height: 32),
          ...question.choices.map((choice) {
            return SurveyOptionButton(
              text: choice.text,
              isSelected: _answers[question.id] == choice.id,
              onPressed: () => _selectOption(question.id, choice.id, questions.length),
              selectedColor: Colors.pink,
              unselectedColor: Colors.white,
              borderColor: Colors.pink,
              unselectedTextColor: Colors.pink,
            );
          }),
          const Spacer(),
          if (surveyState.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SurveyProgressBar(
                currentStep: _currentQuestionIndex,
                totalSteps: questions.length,
                color: Colors.pink,
              ),
            ),
        ],
      ),
    );
  }
}