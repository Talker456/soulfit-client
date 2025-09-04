import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart'; // 공용 AppBar 위젯 import

// --- 1. 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---

// 신청한 모임의 상태를 나타내는 enum
enum ApplicationStatus { approved, pending, completed }

// 신청한 모임 하나의 정보를 담는 클래스
class AppliedGroup {
  final String date;
  final String title;
  final String location;
  final int price;
  final int currentParticipants;
  final int maxParticipants;
  final String imageUrl;
  final ApplicationStatus status;

  AppliedGroup({
    required this.date,
    required this.title,
    required this.location,
    required this.price,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.imageUrl,
    required this.status,
  });
}

// AI 요약 정보를 담는 클래스
class AiSummary {
  final int totalParticipation;
  final List<String> mainActivities;
  final List<String> nextRecommendations;

  AiSummary({
    required this.totalParticipation,
    required this.mainActivities,
    required this.nextRecommendations,
  });
}

// 호스팅 내역 하나의 정보를 담는 클래스
class HostingRecord {
  final String title;
  final String location;
  final int participants;
  final int revenue;
  final String imageUrl;

  HostingRecord({
    required this.title,
    required this.location,
    required this.participants,
    required this.revenue,
    required this.imageUrl,
  });
}

// 특정 월의 호스팅 정보를 담는 클래스
class HostedIncome {
  final DateTime month;
  final int totalRevenue;
  final List<HostingRecord> records;

  HostedIncome({
    required this.month,
    required this.totalRevenue,
    required this.records,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
final dummyAiSummary = AiSummary(
  totalParticipation: 6,
  mainActivities: ['한강 라이딩', '북촌 투어', '야경 감상'],
  nextRecommendations: ['뚝섬 라이딩', '향수 만들기', '클라이밍'],
);

final List<AppliedGroup> dummyAppliedGroups = [
  AppliedGroup(
    date: '2025.07.18',
    title: '거북 베이킹',
    location: '수원',
    price: 30000,
    currentParticipants: 6,
    maxParticipants: 8,
    imageUrl: 'https://via.placeholder.com/100x100/A2E9F0/333333.png?text=🐢',
    status: ApplicationStatus.approved,
  ),
  AppliedGroup(
    date: '2025.07.15',
    title: '거북 베이킹',
    location: '수원',
    price: 30000,
    currentParticipants: 6,
    maxParticipants: 8,
    imageUrl: 'https://via.placeholder.com/100x100/A2E9F0/333333.png?text=🐢',
    status: ApplicationStatus.pending,
  ),
  AppliedGroup(
    date: '2025.07.10',
    title: '거북 배드민턴',
    location: '강남',
    price: 3000,
    currentParticipants: 24,
    maxParticipants: 30,
    imageUrl: 'https://via.placeholder.com/100x100/FFDDC1/333333.png?text=🏸',
    status: ApplicationStatus.completed,
  ),
];

// 호스트 더미 데이터
final List<HostedIncome> dummyHostedIncomes = [
  HostedIncome(
    month: DateTime(2024, 1),
    totalRevenue: 450000,
    records: [
      HostingRecord(
        title: '아침을 여는 명상',
        location: '서울 강남구',
        participants: 5,
        revenue: 150000,
        imageUrl: 'https://via.placeholder.com/100x100/A2E9F0/333333.png?text=🧘',
      ),
      HostingRecord(
        title: '저녁 힐링 요가',
        location: '서울 강남구',
        participants: 10,
        revenue: 300000,
        imageUrl: 'https://via.placeholder.com/100x100/FFE5E5/333333.png?text=🧘',
      ),
    ],
  ),
  HostedIncome(
    month: DateTime(2023, 12),
    totalRevenue: 600000,
    records: [
      HostingRecord(
        title: '주말 명상 클래스',
        location: '서울 마포구',
        participants: 8,
        revenue: 240000,
        imageUrl: 'https://via.placeholder.com/100x100/E5FFE5/333333.png?text=🧘',
      ),
      HostingRecord(
        title: '평일 저녁 명상',
        location: '서울 마포구',
        participants: 12,
        revenue: 360000,
        imageUrl: 'https://via.placeholder.com/100x100/E5E5FF/333333.png?text=🧘',
      ),
    ],
  ),
];

// --- 3. 화면을 그리는 메인 위젯 ---
class PastApplyList extends StatefulWidget {
  const PastApplyList({super.key});

  @override
  State<PastApplyList> createState() => _PastApplyListState();
}

class _PastApplyListState extends State<PastApplyList> {
  // 현재 선택된 탭을 관리 (0: 참가자, 1: 호스트)
  int _selectedTabIndex = 0;
  
  // 숫자 포맷터
  final _numberFormat = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        showBackButton: false, // 이 화면은 뒤로가기 버튼이 필요 없으므로 false
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // --- 참가자/호스트 탭 선택 위젯 ---
          _buildTabs(),
          // 선택된 탭에 따라 다른 화면을 보여줌
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildParticipantView() // 참가자 화면
                : _buildHostView(), // 호스트 화면 (지금은 비어있음)
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 환불 규정 Bottom Sheet를 화면에 보여주는 함수
  void _showRefundBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: Color(0xFFE9F7E9),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 28),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    '환불 규정',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
              const SizedBox(height: 24),
              const Text('4일전 - 100% 환불', style: TextStyle(fontSize: 16, height: 1.8)),
              const Text('3일전 - 90% 환불', style: TextStyle(fontSize: 16, height: 1.8)),
              const Text('2일전 - 50% 환불', style: TextStyle(fontSize: 16, height: 1.8)),
              const Text('1일전 - 환불 불가', style: TextStyle(fontSize: 16, height: 1.8)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('환불이 정상적으로 신청되었습니다.'),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: const Color(0xFFB9E4C9),
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  '환불 신청하기',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 참가자/호스트 탭 위젯
  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
      ),
      child: Row(
        children: [
          _buildTabItem('참가자', 0),
          _buildTabItem('호스트', 1),
        ],
      ),
    );
  }

  // 재사용 가능한 탭 아이템
  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.black : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // '참가자' 탭을 눌렀을 때 보여줄 화면
  Widget _buildParticipantView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('AI 요약'),
          _buildAiSummaryCard(dummyAiSummary),
          const SizedBox(height: 32),
          _buildSectionTitle('신청한 모임'),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyAppliedGroups.length,
            itemBuilder: (context, index) {
              return _buildAppliedGroupCard(dummyAppliedGroups[index]);
            },
          ),
        ],
      ),
    );
  }

  // '호스트' 탭을 눌렀을 때 보여줄 화면
  Widget _buildHostView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 월별 수익 카드들
            Column(
              children: dummyHostedIncomes.map((income) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 월과 총 수익 정보
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${income.month.year}.${income.month.month}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '총 수익: ${NumberFormat('#,###').format(income.totalRevenue)}원',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // 호스팅 기록 카드들
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: income.records.length,
                          itemBuilder: (context, index) {
                            return _buildHostingRecordCard(income.records[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 호스팅 기록 카드 위젯
  Widget _buildHostingRecordCard(HostingRecord record) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // 모임 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(
                    Icons.sports_gymnastics,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 모임 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    record.location,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '참가자 ${record.participants}명',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '수익: ${_numberFormat.format(record.revenue)}원',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 섹션 제목 위젯
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // AI 요약 카드 위젯
  Widget _buildAiSummaryCard(AiSummary summary) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeywordChip('전체 ${summary.totalParticipation}회 참여', isHighlighted: true),
        const SizedBox(height: 16),
        const Text('주요 활동', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: summary.mainActivities.map((activity) => _buildKeywordChip(activity)).toList(),
        ),
        const SizedBox(height: 16),
        const Text('다음 추천', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children: summary.nextRecommendations.map((rec) => _buildKeywordChip(rec)).toList(),
        ),
      ],
    );
  }

  // 재사용 가능한 키워드 칩 위젯
  Widget _buildKeywordChip(String label, {bool isHighlighted = false}) {
    return Chip(
      label: Text(label),
      backgroundColor: isHighlighted ? const Color(0xFFE4FFDF) : Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  // 신청한 모임 카드 위젯
  Widget _buildAppliedGroupCard(AppliedGroup group) {
    final BuildContext context = this.context;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF79C72B), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(group.date, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    group.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('[${group.location}] ${group.title}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('${group.price}원 · ${group.currentParticipants}명/${group.maxParticipants}명', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatusChip(group.status),
                    if (group.status != ApplicationStatus.completed) const SizedBox(height: 4),
                    if (group.status != ApplicationStatus.completed)
                      TextButton(
                        onPressed: () {
                          _showRefundBottomSheet(context);
                        },
                        child: const Text('취소하기', style: TextStyle(color: Colors.purple, decoration: TextDecoration.underline)),
                      ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  // 모임 상태를 표시하는 칩 위젯
  Widget _buildStatusChip(ApplicationStatus status) {
    String text;
    Color color;
    switch (status) {
      case ApplicationStatus.approved:
        text = '참여 승인';
        color = Colors.green;
        break;
      case ApplicationStatus.pending:
        text = '승인 대기';
        color = Colors.orange;
        break;
      case ApplicationStatus.completed:
        text = '참여 완료';
        color = Colors.grey;
        break;
    }
    return Text(text, style: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  // 하단 네비게이션 바 (사용자가 제공한 코드)
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0, // 이 화면이 홈 탭이라면 0
      selectedItemColor: const Color(0xBC37A23C),
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
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PastApplyList(),
    ),
  );
}