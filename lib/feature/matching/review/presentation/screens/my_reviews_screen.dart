
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/review/presentation/provider/review_provider.dart';
import 'package:soulfit_client/feature/matching/review/presentation/widget/review_card.dart';

import '../state/my_reviews_state.dart';

class MyReviewsScreen extends ConsumerWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myReviewsNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('내가 작성한 리뷰')),
      body: _buildBody(state),
    );
  }

  Widget _buildBody(MyReviewsState state) {
    switch (state.status) {
      case MyReviewsStatus.loading:
      case MyReviewsStatus.initial:
        return const Center(child: CircularProgressIndicator());
      case MyReviewsStatus.error:
        return Center(child: Text(state.error ?? '리뷰를 불러오는데 실패했습니다.'));
      case MyReviewsStatus.success:
        if (state.reviews.isEmpty) {
          return const Center(child: Text('아직 작성한 리뷰가 없습니다.'));
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
