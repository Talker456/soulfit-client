import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/create_meeting_providers.dart';

class Step4Cost extends ConsumerWidget {
  const Step4Cost({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createMeetingProvider);
    final notifier = ref.read(createMeetingProvider.notifier);
    final d = state.draft;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('준비물', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...List.generate(
            d.equipments.length,
            (i) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(hintText: '준비물 ${i + 1}'),
                      onChanged:
                          (v) => notifier.patch((d) => d.equipments[i] = v),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        () => notifier.patch((d) => d.equipments.removeAt(i)),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ],
              ),
            ),
          ),
          OutlinedButton.icon(
            onPressed: () => notifier.patch((d) => d.equipments.add('')),
            icon: const Icon(Icons.add),
            label: const Text('추가'),
          ),

          const SizedBox(height: 16),
          Text('픽업 가능 여부', style: Theme.of(context).textTheme.titleMedium),
          Row(
            children: [
              Checkbox(
                value: d.pickUpAvailable,
                onChanged:
                    (_) => notifier.patch((d) => d.pickUpAvailable = true),
              ),
              const Text('가능'),
              const SizedBox(width: 16),
              Checkbox(
                value: !d.pickUpAvailable,
                onChanged:
                    (_) => notifier.patch((d) => d.pickUpAvailable = false),
              ),
              const Text('불가능'),
            ],
          ),

          const SizedBox(height: 16),
          Text('인원 및 참가비', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '최대 인원(명)'),
                  onChanged:
                      (v) =>
                          notifier.patch((d) => d.capacity = int.tryParse(v)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: '1인당 비용(원)'),
                  onChanged:
                      (v) => notifier.patch(
                        (d) => d.pricePerPerson = int.tryParse(v),
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            minLines: 3,
            maxLines: 6,
            decoration: const InputDecoration(labelText: '참가비 구성(선택)'),
            onChanged: (v) => notifier.patch((d) => d.costNote = v),
          ),
        ],
      ),
    );
  }
}
