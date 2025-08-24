import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/create_meeting_providers.dart';
import '../../state/create_meeting_state.dart';

class Step2Schedule extends ConsumerWidget {
  const Step2Schedule({super.key});
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
          _DateField(
            label: '시작일',
            date: d.startDate,
            onPick: (v) => notifier.patch((d) => d.startDate = v),
          ),
          const SizedBox(height: 8),
          _DateField(
            label: '종료일',
            date: d.endDate,
            onPick: (v) => notifier.patch((d) => d.endDate = v),
          ),
          const SizedBox(height: 16),
          Text('세부일정 설정', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          ...List.generate(d.schedules.length, (i) {
            final item = d.schedules[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: '분'),
                      onChanged:
                          (v) => notifier.patch(
                            (d) => item.minutes = int.tryParse(v) ?? 0,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(hintText: '스케줄 제목'),
                      onChanged: (v) => notifier.patch((d) => item.title = v),
                    ),
                  ),
                  IconButton(
                    onPressed:
                        () => notifier.patch((d) => d.schedules.removeAt(i)),
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                ],
              ),
            );
          }),
          OutlinedButton.icon(
            onPressed:
                () => notifier.patch((d) => d.schedules.add(ScheduleItem())),
            icon: const Icon(Icons.add),
            label: const Text('스케줄 추가'),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final ValueChanged<DateTime> onPick;
  const _DateField({
    required this.label,
    required this.date,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: date == null ? '' : _fmt(date!)),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        final now = DateTime.now();
        final picked = await showDatePicker(
          context: context,
          initialDate: date ?? now,
          firstDate: DateTime(now.year - 1),
          lastDate: DateTime(now.year + 5),
        );
        if (picked != null) onPick(picked);
      },
    );
  }
}

String _fmt(DateTime d) =>
    '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
