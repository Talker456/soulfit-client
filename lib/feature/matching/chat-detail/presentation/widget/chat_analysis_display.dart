import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_room_params.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_analysis_state.dart';

class ChatAnalysisDisplay extends ConsumerWidget {
  final ChatRoomParams params;

  const ChatAnalysisDisplay({super.key, required this.params});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(chatAnalysisNotifierProvider(params));

    return analysisAsync.when(
      data: (analysisState) => switch (analysisState) {
        ChatAnalysisLoading() ||
        ChatAnalysisInitial() =>
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text("대화 분석 중...")),
          ),
        ChatAnalysisError(:final message) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(message, style: const TextStyle(color: Colors.red))),
          ),
        ChatAnalysisLoaded(:final analysis) => SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '대화 분석 결과',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildSection(
                  context,
                  title: '대화 분위기',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(analysis.vibe.summary),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        children: analysis.vibe.keywords
                            .map((keyword) => Chip(label: Text(keyword)))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildSection(
                  context,
                  title: '관심도',
                  content: Text(analysis.interestLevel),
                ),
                const SizedBox(height: 16),
                _buildComparisonSection(
                  context,
                  title: '성향',
                  userAData: analysis.personality.userA.join(', '),
                  userBData: analysis.personality.userB.join(', '),
                ),
                const SizedBox(height: 16),
                _buildComparisonSection(
                  context,
                  title: '공감',
                  userAData: analysis.empathy.userA,
                  userBData: analysis.empathy.userB,
                ),
                const SizedBox(height: 16),
                _buildComparisonSection(
                  context,
                  title: '답장 속도',
                  userAData: analysis.responseSpeed.userA,
                  userBData: analysis.responseSpeed.userB,
                ),
                const SizedBox(height: 16),
                _buildComparisonSection(
                  context,
                  title: '질문 빈도',
                  userAData: analysis.questionFrequency.userA,
                  userBData: analysis.questionFrequency.userB,
                ),
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

  Widget _buildSection(BuildContext context, {required String title, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }

  Widget _buildComparisonSection(BuildContext context,
      {required String title, required String userAData, required String userBData}) {
    return _buildSection(
      context,
      title: title,
      content: Row(
        children: [
          Expanded(child: Text('나: $userAData')),
          Expanded(child: Text('상대: $userBData')),
        ],
      ),
    );
  }
}