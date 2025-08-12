import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/create_meeting_providers.dart';

class Step5Question extends ConsumerWidget {
  const Step5Question({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(createMeetingProvider.notifier);
    final d = ref.watch(createMeetingProvider).draft;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('참가자 필수 질문지', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Expanded(
            child: TextField(
              minLines: 6,
              maxLines: 12,
              decoration: const InputDecoration(hintText: '질문을 설정하세요'),
              onChanged: (v) => notifier.patch((d) => d.requiredQuestion = v),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: OutlinedButton(
              onPressed: () => notifier.patch((d) => d.requiredQuestion = ''),
              child: const Text('질문 설정 안 함'),
            ),
          ),
        ],
      ),
    );
  }
}
