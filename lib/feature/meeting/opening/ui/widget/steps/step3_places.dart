import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/create_meeting_providers.dart';

class Step3Places extends ConsumerWidget {
  const Step3Places({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createMeetingProvider);
    final notifier = ref.read(createMeetingProvider.notifier);
    final d = state.draft;

    Widget mapBox(String hint) => Container(
      height: 160,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100,
      ),
      child: Center(
        child: Text(hint, style: const TextStyle(color: Colors.black54)),
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('모이는 장소', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          mapBox('지도 컴포넌트(추후 SDK 연동)'),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(hintText: '지번, 도로명, 건물명으로 검색'),
            onChanged: (v) => notifier.patch((d) => d.meetingPlaceSearch = v),
          ),
          const SizedBox(height: 16),
          Text('모임 진행 장소', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          mapBox('선택된 장소 미리보기'),
          const SizedBox(height: 8),
          TextField(
            decoration: const InputDecoration(hintText: '상세 주소(선택)'),
            onChanged: (v) => notifier.patch((d) => d.meetingPlaceDetail = v),
          ),
        ],
      ),
    );
  }
}
