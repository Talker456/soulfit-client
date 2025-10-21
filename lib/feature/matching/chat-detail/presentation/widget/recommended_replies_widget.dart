import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/chat-detail/domain/entity/chat_room_params.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/provider/chat_detail_provider.dart';
import 'package:soulfit_client/feature/matching/chat-detail/presentation/state/chat_detail_state.dart';

class RecommendedRepliesWidget extends ConsumerWidget {
  final ChatRoomParams params;
  final Function(String) onRecommendationSelected;

  const RecommendedRepliesWidget({
    super.key,
    required this.params,
    required this.onRecommendationSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatDetailNotifierProvider(params));

    return state.when(
      data: (data) {
        if (data is! ChatDetailLoaded) {
          return const Center(child: Text('데이터를 불러오는 중입니다.'));
        }
        if (data.isFetchingRecommendations) {
          return const Center(child: CircularProgressIndicator());
        }
        if (data.recommendedReplies == null || data.recommendedReplies!.isEmpty) {
          return const Center(child: Text('추천 답장이 없습니다.'));
        }
        return ListView.builder(
          itemCount: data.recommendedReplies!.length,
          itemBuilder: (context, index) {
            final recommendation = data.recommendedReplies![index];
            return ListTile(
              title: Text(recommendation.text),
              onTap: () => onRecommendationSelected(recommendation.text),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('오류: $error')),
    );
  }
}
