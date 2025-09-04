import 'package:flutter/material.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import 'package:soulfit_client/feature/dating/dating_filter.dart';

class RecommendedUser {
  final String name;
  final int age;
  final double distance; // km 단위ff
  final String imageUrl;

  RecommendedUser({
    required this.name,
    required this.age,
    required this.distance,
    required this.imageUrl,
  });
}

// 첫인상 투표 정보를 담는 클래스
class FirstImpressionVote {
  final String name;
  final String message;
  final String imageUrl;

  FirstImpressionVote({
    required this.name,
    required this.message,
    required this.imageUrl,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
final List<RecommendedUser> dummyRecommendedUsers = [
  RecommendedUser(name: 'Halima', age: 19, distance: 16, imageUrl: 'https://picsum.photos/300/400?random=1'),
  RecommendedUser(name: 'Vanessa', age: 18, distance: 0, imageUrl: 'https://picsum.photos/300/400?random=2'),
  RecommendedUser(name: 'James', age: 20, distance: 2.2, imageUrl: 'https://picsum.photos/300/400?random=3'),
];

final FirstImpressionVote dummyVote = FirstImpressionVote(
  name: 'Tyler',
  message: 'How r u?',
  imageUrl: 'https://picsum.photos/100/100?random=4',
);

// --- 3. 화면을 그리는 메인 위젯 ---
class DatingMain extends StatelessWidget {
  const DatingMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // --- AppBar 섹션 ---
      appBar: SharedAppBar(
        showBackButton: false,
        // 로고 색상과 스타일을 이미지에 맞게 커스텀합니다.
        title: Text(
          'soulfit',
          style: TextStyle(
            color: Colors.pink[300], // 핑크 계열로 색상 변경
            fontSize: 28,
            fontFamily: 'Arima Madurai',
            fontWeight: FontWeight.w700,
          ),
        ),
        // AppBar 오른쪽에 표시될 아이콘 버튼 목록입니다.
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black54),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DatingFilter()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined, color: Colors.black54),
            onPressed: () => print('Send button tapped!'),
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () => print('Search button tapped!'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildAdBanner(),
            const SizedBox(height: 24),
            _buildSection(
              title: '추천 유저',
              onMorePressed: () => print('추천 유저 더보기 클릭!'),
              content: _buildRecommendedUserList(),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '첫인상 투표',
              onMorePressed: () => print('참여하러가기 클릭!'),
              moreText: '참여하러가기 >',
              content: _buildFirstImpressionCard(dummyVote),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // --- BottomNavigationBar 섹션 ---
      // 요청하신 대로 SharedNavigationBar를 직접 적용합니다.
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: 탭 처리 구현
        },
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 광고 배너 위젯
  Widget _buildAdBanner() {
    return Padding( 
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.pink.shade100,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text('광고', style: TextStyle(fontSize: 48, color: Colors.grey[400])),
        ),
      ),
    );
  }

  // 재사용 가능한 섹션 위젯 (제목 + 더보기 버튼 + 내용)
  Widget _buildSection({
    required String title,
    required VoidCallback onMorePressed,
    required Widget content,
    String moreText = '더보기',
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: onMorePressed,
                child: Text(moreText, style: TextStyle(color: Colors.grey[600])),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }

  // 추천 유저 가로 스크롤 목록
  Widget _buildRecommendedUserList() {
    return SizedBox(
      height: 240, // 높이 증가
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: dummyRecommendedUsers.length,
        itemBuilder: (context, index) {
          return _buildRecommendedUserCard(dummyRecommendedUsers[index]);
        },
      ),
    );
  }

  // 추천 유저 카드
  Widget _buildRecommendedUserCard(RecommendedUser user) {
    return Container(
      width: 160, // 너비 증가
      margin: const EdgeInsets.only(right: 12),
      child: AspectRatio(
        aspectRatio: 3/4, // 3:4 비율 설정
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // 배경 이미지
              Image.network(
                user.imageUrl,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
              // 하단 그라데이션
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7)
                    ],
                    stops: const [0.6, 1.0], // 그라데이션 위치 조정
                  ),
                ),
              ),
              // 하단 텍스트 정보
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.distance.toString()} km away',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${user.name}, ${user.age}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 첫인상 투표 카드
  Widget _buildFirstImpressionCard(FirstImpressionVote vote) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2,
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(vote.imageUrl),
          ),
          title: Text(vote.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(vote.message),
          trailing: const Icon(Icons.chevron_right, size: 28),
          onTap: () => print('첫인상 투표 카드 클릭!'),
        ),
      ),
    );
  }

  // _buildBottomNavBar 메서드는 이제 SharedNavigationBar로 대체되었으므로 삭제했습니다.
}

// --- 이 파일을 독립적으로 실행하기 위한 main 함수 ---
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatingMain(),
    ),
  );
}
