import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/impression_providers.dart';

class ImpressionCheckScreen extends ConsumerWidget {
  final String? targetUserId;
  const ImpressionCheckScreen({super.key, this.targetUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final effectiveId =
        (targetUserId == null || targetUserId!.isEmpty) ? 'me' : targetUserId!;

    final asyncRes = ref.watch(impressionResultProvider(effectiveId));

    return Scaffold(
      appBar: AppBar(title: const Text('호감 확인')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: asyncRes.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (e, _) => _ErrorView(
                message: '오류가 발생했어요.\n$e',
                onRetry:
                    () => ref.refresh(impressionResultProvider(effectiveId)),
              ),
          data: (res) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ChipLike(isLiked: res.isLiked, from: res.fromUserName),
                const SizedBox(height: 16),
                Text(
                  res.isLiked
                      ? '${res.fromUserName}님이 당신을 좋아해요 💖'
                      : '${res.fromUserName}님은 아직 마음을 결정하지 않았어요',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                if (res.comment.isNotEmpty) ...[
                  Text('남긴 한마디', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEEF5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(res.comment),
                  ),
                ],
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  child: const Text('확인'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ChipLike extends StatelessWidget {
  final bool isLiked;
  final String from;
  const _ChipLike({required this.isLiked, required this.from});

  @override
  Widget build(BuildContext context) {
    final bg = isLiked ? const Color(0xFFFF4DA6) : const Color(0xFFEDEDED);
    final fg = isLiked ? Colors.white : Colors.black87;
    final label = isLiked ? '좋아요' : '보류';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$from • $label',
        style: TextStyle(color: fg, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          OutlinedButton(onPressed: onRetry, child: const Text('다시 시도')),
        ],
      ),
    );
  }
}
