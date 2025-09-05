import 'package:flutter/material.dart';
// 1. 요청하신 core widget guide의 위젯들을 import 합니다.
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';

// --- 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---
class RecommendedUser {
  final String name;
  final int age;
  final String imageUrl;

  const RecommendedUser({
    required this.name,
    required this.age,
    required this.imageUrl,
  });
}

// --- 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
final List<RecommendedUser> dummyUsers = [
  RecommendedUser(name: 'Leilani', age: 19, imageUrl: 'https://picsum.photos/400/600?random=1'),
  RecommendedUser(name: 'Annabelle', age: 20, imageUrl: 'https://picsum.photos/400/600?random=2'),
  RecommendedUser(name: 'Reagan', age: 24, imageUrl: 'https://picsum.photos/400/600?random=3'),
  RecommendedUser(name: 'Hadley', age: 25, imageUrl: 'https://picsum.photos/400/600?random=4'),
  RecommendedUser(name: 'Kyle', age: 24, imageUrl: 'https://picsum.photos/400/600?random=5'),
  RecommendedUser(name: 'Another Kyle', age: 24, imageUrl: 'https://picsum.photos/400/600?random=6'),
];


// --- 화면을 그리는 메인 위젯 ---
class RecommendedUserScreen extends StatelessWidget {
  const RecommendedUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 2. 요청하신 SharedAppBar 위젯을 사용합니다.
      appBar: SharedAppBar(
        showBackButton: true,
        title: const Text('추천 유저', style: TextStyle(color: Colors.black)),
      ),
      // 3. 요청하신 SharedNavigationBar 위젯을 사용합니다.
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: 탭 처리 구현
        },
      ),
      body: _buildUserGrid(),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 추천 유저 목록을 2열 그리드 형태로 보여주는 위젯
  Widget _buildUserGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      // 그리드 아이템의 개수
      itemCount: dummyUsers.length,
      // 그리드 레이아웃 설정
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 한 줄에 2개씩
        crossAxisSpacing: 16, // 가로 간격
        mainAxisSpacing: 16, // 세로 간격
        childAspectRatio: 0.65, // 카드의 가로세로 비율
      ),
      // 각 그리드 아이템을 만드는 부분
      itemBuilder: (context, index) {
        final user = dummyUsers[index];
        return _UserCard(user: user);
      },
    );
  }
}

// --- 재사용 가능한 유저 카드 위젯 ---
class _UserCard extends StatelessWidget {
  final RecommendedUser user;
  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        // fit: StackFit.expand를 사용해 자식들이 Stack 크기에 꽉 차도록 합니다.
        fit: StackFit.expand,
        children: [
          // 1. 배경 이미지
          Image.network(
            user.imageUrl,
            fit: BoxFit.cover,
            // 이미지를 불러오는 동안 로딩 인디케이터 표시
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            // 이미지 로딩 실패 시 에러 아이콘 표시
            errorBuilder: (context, error, stackTrace) {
              return const Center(child: Icon(Icons.error, color: Colors.red));
            },
          ),
          
          // 2. 이미지 위에 글씨가 잘 보이도록 검은색 그라데이션 오버레이 추가
          _buildGradientOverlay(),
          
          // 3. 이름, 나이, 버튼들을 포함하는 하단 정보 영역
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이름과 나이
                Text(
                  '${user.name}, ${user.age}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 2)],
                  ),
                ),
                const SizedBox(height: 8),
                // X, 하트 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(
                      icon: Icons.close,
                      onPressed: () => print('${user.name}님을 거절했습니다.'),
                    ),
                    _buildActionButton(
                      icon: Icons.favorite_border,
                      onPressed: () => print('${user.name}님에게 호감을 보냈습니다.'),
                      iconColor: Colors.pinkAccent,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 검은색 그라데이션 오버레이 위젯
  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.5, 1.0],
        ),
      ),
    );
  }

  // X, 하트 버튼을 만드는 위젯
  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onPressed,
    Color iconColor = Colors.white,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withOpacity(0.3),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }
}

// --- 이 파일을 독립적으로 실행하기 위한 main 함수 ---
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecommendedUserScreen(),
    ),
  );
}
