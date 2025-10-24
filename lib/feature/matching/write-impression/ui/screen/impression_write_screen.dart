import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/impression_write_providers.dart';
import '../../ui/widgets/tag_chip.dart';
import '../../ui/widgets/comment_box.dart';

class ImpressionWriteScreen extends ConsumerWidget {
  final String? targetUserId;
  const ImpressionWriteScreen({super.key, this.targetUserId});

  static const tagDefs = [
    ('kind', '다정한'),
    ('positive', '긍정적'),
    ('cool', '쿨한'),
    ('active', '적극적'),
    ('cute', '귀여운'),
    ('quirky', '엉뚱한'),
    ('witty', '재치있는'),
    ('comfortable', '편한'),
    ('blunt', '무뚝뚝'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(impressionWriteProvider(targetUserId));
    final notifier = ref.read(impressionWriteProvider(targetUserId).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('후기 작성')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              '상대방은 어떤 사람이었나요?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final (tagId, label) in tagDefs)
                  TagChip(
                    label: label,
                    selected: state.selectedTags.contains(tagId),
                    onTap: () => notifier.toggleTag(tagId),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            CommentBox(
              value: state.comment,
              onChanged: notifier.setComment,
              maxLen: 150,
            ),
            const Spacer(),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  state.error!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            if (state.successId != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '제출 완료: ${state.successId!}',
                  style: const TextStyle(color: Colors.green),
                ),
              ),
            FilledButton(
              onPressed:
                  state.canSubmit && !state.loading ? notifier.submit : null,
              child: Text(state.loading ? '작성 중...' : '작성완료'),
            ),
          ],
        ),
      ),
    );
  }
}
