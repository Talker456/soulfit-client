import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/create_meeting_providers.dart';
import '../widget/common/progress_bar.dart';
import '../widget/steps/step1_basic.dart';
import '../widget/steps/step2_schedule.dart';
import '../widget/steps/step3_places.dart';
import '../widget/steps/step4_cost.dart';
import '../widget/steps/step5_question.dart';
import '../widget/steps/step6_done.dart';

class CreateMeetingWizardScreen extends ConsumerWidget {
  const CreateMeetingWizardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createMeetingProvider);
    final notifier = ref.read(createMeetingProvider.notifier);
    final current = state.step;
    const total = 6;
    final isLast = current == total - 1;
    final canNext = notifier.canGoNext();

    return Scaffold(
      appBar: AppBar(
        title: const Text('모임 개설'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => current == 0 ? Navigator.pop(context) : notifier.prev(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: current,
              children: const [
                Step1Basic(),
                Step2Schedule(),
                Step3Places(),
                Step4Cost(),
                Step5Question(),
                Step6Done(),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: (current > 0 && !isLast) ? notifier.prev : null,
                    child: const Text('이전'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed:
                        !isLast && !canNext
                            ? null
                            : () {
                              if (isLast) {
                                Navigator.pop(context);
                                return;
                              }
                              if (current == total - 2) {
                                final msg = notifier.validationMessage();
                                if (msg != null) {
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(SnackBar(content: Text(msg)));
                                  return;
                                }
                                notifier.submit();
                                return;
                              }
                              final msg = notifier.tryNext();
                              if (msg != null) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text(msg)));
                              }
                            },
                    child: Text(isLast ? '확인' : '다음'),
                  ),
                ),
              ],
            ),
          ),
          ProgressBar(value: (current + 1) / total),
        ],
      ),
    );
  }
}
