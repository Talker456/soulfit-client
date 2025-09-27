import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import 'package:soulfit_client/feature/matching/filter/presentation/screen/dating_filter.dart';
import 'package:soulfit_client/feature/matching/voting/presentation/screen/first_impression_evaluated.dart';
import 'package:soulfit_client/feature/matching/voting/presentation/screen/first_impression_vote.dart' as vote_screen;
import 'package:soulfit_client/feature/matching/recommendation/presentation/screen/recommand_user.dart' as recommendation;
import '../riverpod/dating_main_provider.dart';
import '../../domain/entities/recommended_user.dart';
import '../../domain/entities/first_impression_vote.dart';


class DatingMain extends ConsumerStatefulWidget {
  const DatingMain({super.key});

  @override
  ConsumerState<DatingMain> createState() => _DatingMainState();
}

class _DatingMainState extends ConsumerState<DatingMain> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(datingMainProvider.notifier).loadRecommendedUsers();
      ref.read(datingMainProvider.notifier).loadLatestFirstImpressionVote();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(datingMainProvider);

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
              onMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const recommendation.RecommendedUserScreen()),
                );
              },
              content: _buildRecommendedUserList(state.recommendedUsers, state.isLoadingUsers),
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: '첫인상 투표',
              onMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                );
              },
              moreText: '참여하러가기 >',
              content: _buildFirstImpressionCard(context, state.latestVote, state.isLoadingVote),
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
  Widget _buildRecommendedUserList(List<RecommendedUser> users, bool isLoading) {
    if (isLoading) {
      return const SizedBox(
        height: 240,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (users.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: Text('추천 유저가 없습니다.', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return _buildRecommendedUserCard(users[index]);
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
                user.profileImageUrl,
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
  Widget _buildFirstImpressionCard(BuildContext context, FirstImpressionVote? vote, bool isLoading) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          child: SizedBox(
            height: 80,
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }

    if (vote == null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          elevation: 2,
          shadowColor: Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text('새로운 첫인상 투표가 없습니다.', style: TextStyle(color: Colors.grey)),
            trailing: Icon(Icons.chevron_right, size: 28),
          ),
        ),
      );
    }

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
            backgroundImage: NetworkImage(vote.userProfileImageUrl),
          ),
          title: Text(vote.userName, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(vote.message),
          trailing: const Icon(Icons.chevron_right, size: 28),
          onTap: () {
            // 투표를 읽음 처리
            ref.read(datingMainProvider.notifier).markVoteAsRead(vote.id);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const vote_screen.FirstImpressionVoteScreen()),
            );
          },
        ),
      ),
    );
  }

  // _buildBottomNavBar 메서드는 이제 SharedNavigationBar로 대체되었으므로 삭제했습니다.
}

// --- 이 파일을 독립적으로 실행하기 위한 main 함수 ---
void main() {
  runApp(
    ProviderScope(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DatingMain(),
      ),
    ),
  );
}
