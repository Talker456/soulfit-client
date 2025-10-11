import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import '../provider/review_providers.dart';
import '../widget/star_rating_widget.dart';

/// 모임 리뷰 조회 화면
class GroupReviewScreen extends ConsumerStatefulWidget {
  final String meetingId;

  const GroupReviewScreen({
    super.key,
    required this.meetingId,
  });

  @override
  ConsumerState<GroupReviewScreen> createState() => _GroupReviewScreenState();
}

class _GroupReviewScreenState extends ConsumerState<GroupReviewScreen> {
  @override
  void initState() {
    super.initState();
    // 화면 로드 시 리뷰 데이터 조회
    Future.microtask(() {
      ref.read(reviewProvider.notifier).loadReviews(widget.meetingId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewState = ref.watch(reviewProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(),
      body: Column(
        children: [
          // 헤더 AppBar
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              '후기',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          // 컨텐츠
          Expanded(
            child: _buildContent(reviewState),
          ),
        ],
      ),
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: 네비게이션 처리
        },
      ),
    );
  }

  Widget _buildContent(state) {
    if (state.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('오류가 발생했습니다: ${state.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(reviewProvider.notifier).loadReviews(widget.meetingId);
              },
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    final stats = state.stats;
    final reviews = state.reviews;

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(reviewProvider.notifier).refresh(widget.meetingId);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 평점 섹션
              if (stats != null) ...[
                _buildRatingInfo('모임 평점', stats.groupRating),
                const SizedBox(height: 8),
                _buildRatingInfo('호스트 평점', stats.hostRating),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 24),
              ],

              // 후기 목록 섹션
              Text(
                '후기 ${reviews.length}개',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              if (reviews.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      '아직 작성된 후기가 없습니다.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return _buildReviewCard(reviews[index]);
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingInfo(String label, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        StarRatingWidget(rating: rating, size: 28),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildReviewCard(review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 작성자 프로필 섹션
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(review.authorImageUrl),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.authorName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    StarRatingWidget(rating: review.rating, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      '${review.date} · 리뷰 ${review.reviewCount}개',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.grey),
              onPressed: () {
                // TODO: 메뉴 기능
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 리뷰 내용
        Text(
          review.content,
          style: const TextStyle(fontSize: 15, height: 1.5),
        ),
        // 키워드 표시
        if (review.keywords.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: review.keywords.map((keyword) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Text(
                  keyword,
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
