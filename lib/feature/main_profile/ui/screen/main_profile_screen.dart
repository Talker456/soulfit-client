import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/main_profile_provider.dart';
import '../state/main_profile_state.dart';

class MainProfileScreen extends ConsumerWidget {
  final String viewerUserId;
  final String targetUserId;

  const MainProfileScreen({
    super.key,
    required this.viewerUserId,
    required this.targetUserId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainProfileNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('메인 프로필')),
      body: switch (state) {
        MainProfileInitial() => const Center(child: Text("초기화 중...")),
        MainProfileLoading() => const Center(child: CircularProgressIndicator()),
        MainProfileError(:final message) => Center(child: Text("오류: $message")),
        MainProfileLoaded(:final data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(data.mainProfileInfo.profileImageUrl),
            ),
            const SizedBox(height: 8),
            Text(data.mainProfileInfo.introduction),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: data.mainProfileInfo.personalityKeywords
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            ),
            const Divider(),
            Text("내가 보는 나: ${data.mainProfileInfo.selfKeywords.join(', ')}"),
            Text("상대방이 보는 나: ${data.perceivedByOthersKeywords.join(', ')}"),
            Text("AI가 보는 나: ${data.aiPredictedKeywords.join(', ')}"),
            const Divider(),
            Text("가치관 요약: ${data.valueAnalysis.summary}"),
            const Divider(),
            Text("앨범 (${data.albumImages.length})"),
            Column(
              children: data.albumImages
                  .map((url) => Image.network(url, height: 100))
                  .toList(),
            ),
          ],
        )
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(mainProfileNotifierProvider.notifier).load(viewerUserId, targetUserId);
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
