import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/settings/settings.dart';

// --- 메인 화면 위젯 ---
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. 보내주신 상단 AppBar 코드를 그대로 사용합니다.
      appBar: _buildAppBar(context),
      // 2. 보내주신 하단 BottomNavigationBar 코드를 그대로 사용합니다.
      bottomNavigationBar: _buildBottomNavBar(),
      // 3. 내용이 많으므로 스크롤이 가능하도록 SingleChildScrollView를 사용합니다.
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            // --- 프로필 정보 섹션 ---
            _buildProfileHeader(),
            const SizedBox(height: 24),
            // --- 활동 정보 섹션 (모임 참여, 후기, 쿠폰) ---
            _buildUserActivityStats(),
            const SizedBox(height: 24),
            // --- 호스트 시작하기 배너 ---
            _buildHostBanner(),
            const SizedBox(height: 16),
            // --- 메뉴 목록 ---
            _buildMenuList(),
          ],
        ),
      ),
    );
  }
}

// --- 상단 AppBar (soulfit 로고와 오른쪽 아이콘 2개) ---
PreferredSizeWidget _buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    title: const Text(
      'soulfit',
      style: TextStyle(
        color: Color(0xBC37A13C),
        fontSize: 28,
        fontFamily: 'Arima Madurai',
        fontWeight: FontWeight.w700,
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.send_outlined, color: Colors.black54),
        onPressed: () {
          print('Send button tapped!');
        },
      ),
      IconButton(
        icon: const Icon(Icons.search, color: Colors.black54),
        onPressed: () {
          print('Search button tapped!');
        },
      ),
    ],
  );
}

// --- 하단 BottomNavigationBar ---
Widget _buildBottomNavBar() {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: 4, // 마이페이지가 5번째 아이콘이므로 index 4로 설정
    selectedItemColor: const Color(0xBC37A13C),
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Saved'),
      BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
      BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Alerts'),
      BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
    ],
    onTap: (index) {
      print('Tapped item $index');
    },
  );
}

// --- 위젯 빌더 메서드들 ---

// 프로필 헤더 (사진, 이름, 설정 버튼)
Widget _buildProfileHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      children: [
        // 프로필 사진을 InkWell로 감싸 클릭 반응 추가
        InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            print('프로필 사진 클릭!');
          },
          child: const CircleAvatar(
            radius: 40,
            backgroundColor: Color(0xFFE4FFDF), // 연한 녹색 배경
            child: Icon(
              Icons.person,
              size: 50,
              color: Color(0xFF79C72B),
            ),
          ),
        ),
        const SizedBox(width: 16),
        // 이름
        const Text(
          '소울핏', // 예시 이름
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8), // 이름과 아이콘 사이 간격(띄어쓰기 2개 정도)
        Builder(
          builder: (context) => IconButton(
            onPressed: () {
              _showChangeNameDialog(context);
            },
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.edit,
              size: 20,
              color: Colors.grey,
            ),
          ),
        ),
        const Spacer(),
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// 사용자 활동 통계 (모임 참여, 후기, 쿠폰) - 네모 카드 & 클릭 반응
Widget _buildUserActivityStats() {
  final stats = [
    {'label': '모임 참여', 'value': '10'},
    {'label': '후기', 'value': '11'},
    {'label': '쿠폰', 'value': '12'},
  ];
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(stats.length, (index) {
        final stat = stats[index];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: index == 0 ? 0 : 8, right: index == stats.length - 1 ? 0 : 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                print('${stat['label']} 카드 클릭!');
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Color(0xFF79C72B), width: 1),
                ),
                color: const Color(0xFFF5FFF5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        stat['value']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        stat['label']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}

// '소울핏 호스트 시작하기' 배너 전체를 버튼으로
Widget _buildHostBanner() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        print('소울핏 호스트 시작하기 배너 클릭!');
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFFF5FFF5),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '소울핏 호스트 시작하기',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '당신의 재능을 마음껏 펼치세요.\n수익은 소울핏이 만들어 드립니다.',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFE4FFDF),
                child: Icon(
                  Icons.star,
                  color: Color(0xFF79C72B),
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// 클릭 가능한 메뉴 목록
Widget _buildMenuList() {
  final menuItems = [
    '결제내역',
    '호스트 문의 내역',
    '공지사항',
    'FAQ',
    '고객센터 문의',
    '약관 및 정책',
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.only(left: 8), // 박스보다 띄어쓰기 1개만큼 오른쪽
          title: Text(menuItems[index]),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {
            print('${menuItems[index]} tapped!');
          },
        );
      },
    ),
  );
}

// 이름 변경 팝업을 화면에 보여주는 함수
void _showChangeNameDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Dialog 위젯을 사용하여 팝업의 기본 모양을 만듭니다.
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: _buildChangeNameDialogContent(context),
      );
    },
  );
}

// 팝업의 실제 내용을 만드는 위젯
Widget _buildChangeNameDialogContent(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(24),
    margin: const EdgeInsets.only(top: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min, // 내용물 크기에 맞게 팝업 크기 조절
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16),
        const Text(
          '현재 이름: 소울핏',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 20),
        // 새로운 이름 입력창과 변경하기 버튼
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: '새로운 이름',
                  // 밑줄은 TextField의 기본 디자인입니다.
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {
                 print('팝업 안의 변경하기 버튼 클릭!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              child: const Text('변경하기'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 안내 문구
        Text(
          '한 번 변경하면 30일 동안 변경할 수 없습니다.',
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        ),
        const SizedBox(height: 24),
        // 최종 확인 버튼
        ElevatedButton(
          onPressed: () {
            print('확인하기 버튼 클릭!');
            Navigator.of(context).pop(); // 팝업 닫기
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            backgroundColor: const Color(0xFF79C72B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            '확인하기',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    ),
  );
}


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Profile(),
    ),
  );
}