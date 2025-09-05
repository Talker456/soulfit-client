import 'package:flutter/material.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';

// 반쪽 별을 그리기 위한 커스텀 클리퍼
class HalfStarClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

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
final double dummyGroupRating = 4.5;
final double dummyHostRating = 3.7;

// 키워드 중심 리뷰를 위한 키워드 리스트
final List<String> dummyKeywords = [
  '친절함',
  '시간 준수',
  '재미있음',
  '소통 잘함',
  '배려심'
];

final List<Review> dummyReviews = [
  Review(
    authorName: '김민수',
    authorImageUrl: 'https://placehold.co/100x100/A2E9F0/333333?text=CS',
    rating: 4.5,
    date: '25.7.16',
    reviewCount: 6,
    content: '자연스레 사진에 집중해지는 다한님의 에너지 너무 좋았습니다!! 해주신 작가님이랑 이랑 작가님도 감사드려요!! 작업물도 너무 맘에 들었어요 😃😃',
  ),
  Review(
    authorName: '홍길동',
    authorImageUrl: 'https://placehold.co/100x100/FFDDC1/333333?text=IU',
    rating: 3.5,
    date: '25.7.14',
    reviewCount: 2,
    content: '시간 가는 줄 모르고 즐겼네요. 다음에도 또 참여하고 싶어요!',
  ),
  // 여기에 더 많은 리뷰 데이터를 추가할 수 있습니다.
];


// --- 3. 화면을 그리는 메인 위젯 ---
class HostReview extends StatelessWidget {
  const HostReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SharedAppBar 추가
      appBar: const SharedAppBar(),
      body: Column(
        children: [
          // 기존 "후기" AppBar
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              '호스트 리뷰',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          // 기존 body 내용
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
              // --- 호스트 평점 섹션 ---
              _buildRatingInfo('호스트 평점', dummyHostRating),
              const SizedBox(height: 20),
              
              // --- 키워드 중심 리뷰 섹션 ---
              _buildKeywordSection(),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),

              // --- 후기 목록 섹션 ---
              Text(
                '후기 ${dummyReviews.length}개',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          ),
        ],
      ),
      // SharedNavigationBar 추가
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: 네비게이션 처리
        },
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 키워드 중심 리뷰 섹션을 만드는 위젯
  Widget _buildKeywordSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '키워드 중심 리뷰',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        // 첫 번째 줄 (3개 키워드)
        Row(
          children: [
            _buildKeywordChip(dummyKeywords[0]),
            const SizedBox(width: 8),
            _buildKeywordChip(dummyKeywords[1]),
            const SizedBox(width: 8),
            _buildKeywordChip(dummyKeywords[2]),
          ],
        ),
        const SizedBox(height: 8),
        // 두 번째 줄 (2개 키워드)
        Row(
          children: [
            _buildKeywordChip(dummyKeywords[3]),
            const SizedBox(width: 8),
            _buildKeywordChip(dummyKeywords[4]),
          ],
        ),
      ],
    );
  }

  // 개별 키워드 칩을 만드는 위젯
  Widget _buildKeywordChip(String keyword) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 1,
        ),
      ),
      child: Text(
        keyword,
        style: TextStyle(
          color: Colors.blue.shade700,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // 소수점을 지원하는 별점 위젯을 생성하는 메서드
  Widget _buildStarRating(double rating, {double size = 24}) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          // 완전한 별
          return Icon(
            Icons.star,
            color: Colors.amber,
            size: size,
          );
        } else if (index == rating.floor() && rating % 1 != 0) {
          // 반쪽 별
          return Stack(
            children: [
              Icon(
                Icons.star_border,
                color: Colors.amber,
                size: size,
              ),
              ClipRect(
                clipper: HalfStarClipper(),
                child: Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: size,
                ),
              ),
            ],
          );
        } else {
          // 빈 별
          return Icon(
            Icons.star_border,
            color: Colors.amber,
            size: size,
          );
        }
      }),
    );
  }

  // 평점 정보를 보여주는 위젯
  Widget _buildRatingInfo(String label, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 100, // 텍스트 너비를 고정하여 정렬을 맞춥니다.
          child: Text(
            label, 
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20), // 5개 공백 정도의 간격
        // 별점 아이콘을 만드는 Row
        _buildStarRating(rating, size: 28),
        const SizedBox(width: 8),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    _buildStarRating(review.rating, size: 20),
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

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HostReview(),
    ),
  );
}
