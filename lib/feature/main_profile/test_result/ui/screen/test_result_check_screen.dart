
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/test_answer.dart';
import '../provider/test_result_provider.dart';
import '../state/test_result_state.dart';

class TestResultCheckScreen extends ConsumerStatefulWidget {
  final String testType;

  const TestResultCheckScreen({super.key, required this.testType});

  @override
  ConsumerState<TestResultCheckScreen> createState() => _TestResultCheckScreenState();
}

class _TestResultCheckScreenState extends ConsumerState<TestResultCheckScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the results when the widget is first built
    Future.microtask(() => ref
        .read(testResultNotifierProvider.notifier)
        .getTestResult(widget.testType));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(testResultNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '가치관 검사지',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: switch (state) {
        TestResultInitial() => const Center(child: CircularProgressIndicator()),
        TestResultLoading() =>
          const Center(child: CircularProgressIndicator()),
        TestResultError(:final message) => Center(
            child: Text('오류: $message'),
          ),
        TestResultLoaded(:final testResult) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                shadowColor: Colors.grey.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.green.shade100, width: 1.5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${testResult.testType} 가치관 검사',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: testResult.answers.length,
                        itemBuilder: (context, index) {
                          final qa = testResult.answers[index];
                          if (qa.questionType == QuestionType.multiple) {
                            return _buildMultipleChoiceResult(qa);
                          } else {
                            return _buildDescriptiveResult(qa);
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const Divider(height: 32),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      },
    );
  }

  Widget _buildMultipleChoiceResult(TestAnswer qa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          qa.questionContent,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...qa.choices.map((choice) {
          final isSelected = choice.choiceId == qa.selectedChoiceId;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: isSelected ? const Color(0xFFFDB813) : Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    choice.content,
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected ? Colors.black : Colors.grey[700],
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildDescriptiveResult(TestAnswer qa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          qa.questionContent,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            qa.answerText ?? '답변 없음',
            style: TextStyle(color: Colors.grey[800], height: 1.5),
          ),
        ),
      ],
    );
  }
}
