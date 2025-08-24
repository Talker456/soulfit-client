import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../provider/create_meeting_providers.dart';

class Step1Basic extends ConsumerWidget {
  const Step1Basic({super.key});
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
          Text('제목', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          TextField(
            maxLength: 20,
            decoration: const InputDecoration(hintText: '제목을 입력하세요'),
            onChanged: (v) => notifier.patch((d) => d.title = v),
          ),

          const SizedBox(height: 12),
          Text('설명', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          TextField(
            maxLength: 400,
            minLines: 4,
            maxLines: 8,
            decoration: const InputDecoration(hintText: '설명을 입력하세요'),
            onChanged: (v) => notifier.patch((d) => d.description = v),
          ),

          const SizedBox(height: 16),
          Text('키워드 설정', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: -8,
            children: [
              ...d.keywords.map(
                (k) => InputChip(
                  label: Text(k),
                  onDeleted: () => notifier.patch((d) => d.keywords.remove(k)),
                ),
              ),
              ActionChip(
                label: const Text('+ 키워드'),
                onPressed: () async {
                  final text = await _ask(context, '키워드 입력');
                  if (text != null && text.isNotEmpty) {
                    notifier.patch((d) => d.keywords.add(text));
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 16),
          Text('대표 이미지 설정', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          SizedBox(
            height: 90,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: (d.imagePaths.length + 1).clamp(0, 4),
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final isAdd = i == d.imagePaths.length;
                if (isAdd) {
                  return AspectRatio(
                    aspectRatio: 1,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: image_picker 연동
                        notifier.patch(
                          (d) => d.imagePaths.add('local/path.png'),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text(''),
                    ),
                  );
                }
                return AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        child: const Center(child: Icon(Icons.image)),
                      ),
                      Positioned(
                        right: 4,
                        top: 4,
                        child: InkWell(
                          onTap:
                              () => notifier.patch(
                                (d) => d.imagePaths.removeAt(i),
                              ),
                          child: const CircleAvatar(
                            radius: 10,
                            child: Icon(Icons.close, size: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> _ask(BuildContext context, String title) async {
  final c = TextEditingController();
  return showDialog<String>(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Text(title),
          content: TextField(controller: c, autofocus: true),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, c.text.trim()),
              child: const Text('추가'),
            ),
          ],
        ),
  );
}
