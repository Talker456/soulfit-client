import 'package:flutter/material.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';

// --- 1. 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---
// 개별 리뷰 하나의 정보를 담는 클래스
class Review {
  final String authorName;
  final String authorImageUrl;
  final double rating;
  final String date;
  final String content;
  final int reviewCount; // 해당 유저가 작성한 리뷰 수

  Review({
    required this.authorName,
    required this.authorImageUrl,
    required this.rating,
    required this.date,
    required this.content,
    required this.reviewCount,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
// 백엔드 API가 완성되기 전까지 이 가짜 데이터를 사용해서 UI를 만듭니다.
final double dummyGroupRating = 4.8;
final double dummyHostRating = 5.0;
final List<Review> dummyReviews = [
  Review(
    authorName: '김결',
    authorImageUrl: 'https://placehold.co/100x100/A2E9F0/333333?text=CS',
    rating: 5,
    date: '25.7.16',
    reviewCount: 6,
    content: '자연스레 사진에 집중해지는 다한님의 에너지 너무 좋았습니다!! 해주신 작가님이랑 이랑 작가님도 감사드려요!! 작업물도 너무 맘에 들었어요 😃😃',
  ),
  Review(
    authorName: '아이',
    authorImageUrl: 'https://placehold.co/100x100/FFDDC1/333333?text=IU',
    rating: 4,
    date: '25.7.14',
    reviewCount: 2,
    content: '시간 가는 줄 모르고 즐겼네요. 다음에도 또 참여하고 싶어요!',
  ),
  // 여기에 더 많은 리뷰 데이터를 추가할 수 있습니다.
];


// --- 3. 화면을 그리는 메인 위젯 ---
class GroupReview extends StatelessWidget {
  const GroupReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        showBackButton: true,
        title: const Text('후기'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 모임/호스트 평점 섹션 ---
              _buildRatingInfo('모임 평점', dummyGroupRating),
              const SizedBox(height: 8),
              _buildRatingInfo('호스트 평점', dummyHostRating),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // --- 후기 목록 섹션 ---
              Text(
                '후기 ${dummyReviews.length}개',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dummyReviews.length,
                itemBuilder: (context, index) {
                  return _buildReviewCard(dummyReviews[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 평점 정보를 보여주는 위젯
  Widget _buildRatingInfo(String label, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 80, // 텍스트 너비를 고정하여 정렬을 맞춥니다.
          child: Text(label, style: const TextStyle(fontSize: 16)),
        ),
        // 별점 아이콘을 만드는 Row
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 24,
            );
          }),
        ),
      ],
    );
  }

  // 개별 후기 카드를 만드는 위젯
  Widget _buildReviewCard(Review review) {
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
                Text(review.authorName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    // 별점
                    ...List.generate(5, (index) {
                      return Icon(
                        index < review.rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                    const SizedBox(width: 8),
                    // 날짜 및 리뷰 수
                    Text(
                      '${review.date} · 리뷰 ${review.reviewCount}개',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            // 점 3개 메뉴 버튼
            IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.grey),
              onPressed: () {
                print('${review.authorName}님의 리뷰 메뉴 클릭!');
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
      ],
    );
  }
}

// --- 이 파일을 독립적으로 실행하기 위한 main 함수 ---
// 요청하신 대로 파일 끝에 붙여넣었습니다.
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupReview(),
    ),
  );
}
