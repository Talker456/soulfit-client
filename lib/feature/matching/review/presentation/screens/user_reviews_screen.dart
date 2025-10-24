
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/review/presentation/provider/review_provider.dart';
import 'package:soulfit_client/feature/matching/review/presentation/widget/review_card.dart';

import '../state/user_reviews_state.dart';

class UserReviewsScreen extends ConsumerWidget {
  final int userId;
  const UserReviewsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userReviewsNotifierProvider(userId));

    return Scaffold(
      appBar: AppBar(title: const Text('받은 리뷰')),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(UserReviewsState state) {
    switch (state.status) {
      case UserReviewsStatus.loading:
      case UserReviewsStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case UserReviewsStatus.error:
        return Center(child: Text(state.error ?? '리뷰를 불러오는데 실패했습니다.'));
      case UserReviewsStatus.success:
        if (state.reviews.isEmpty) {
          return const Center(child: Text('아직 받은 리뷰가 없습니다.'));
        }
        return ListView.builder(
          itemCount: state.reviews.length,
          itemBuilder: (context, index) {
            return ReviewCard(review: state.reviews[index]);
          },
        );
    }
  }
}
