import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_analysis_state.dart';

class ChatAnalysisDisplay extends ConsumerWidget {
  final String roomId;

  const ChatAnalysisDisplay({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(chatAnalysisNotifierProvider(roomId));

    return analysisAsync.when(
      data: (analysisState) => switch (analysisState) {
        ChatAnalysisLoading() || ChatAnalysisInitial() => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text("대화 분석 중...")),
          ),
        ChatAnalysisError(:final message) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(message, style: const TextStyle(color: Colors.red))),
          ),
        ChatAnalysisLoaded(:final analysis) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.lightGreen.withOpacity(0.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Mood Icon
                _buildMoodIcon(analysis.mood),
                const SizedBox(width: 12),
                // Keywords
                Expanded(
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: analysis.keywords
                        .map((kw) => Chip(
                              label: Text(kw, style: const TextStyle(fontSize: 12)),
                              padding: EdgeInsets.zero,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 12),
                // Positive Score
                Column(
                  children: [
                    const Text("긍정", style: TextStyle(fontSize: 10)),
                    Text(
                      "${(analysis.positiveScore * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
      },
      loading: () => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(child: Text("대화 분석 로딩 중...")),
      ),
      error: (err, stack) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('분석 오류: $err', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  Widget _buildMoodIcon(String mood) {
    IconData iconData;
    Color color;
    switch (mood) {
      case 'UPBEAT':
        iconData = Icons.sentiment_very_satisfied;
        color = Colors.green;
        break;
      case 'TENSE':
        iconData = Icons.sentiment_very_dissatisfied;
        color = Colors.red;
        break;
      default:
        iconData = Icons.sentiment_neutral;
        color = Colors.grey;
    }
    return Icon(iconData, color: color, size: 32);
  }
}
