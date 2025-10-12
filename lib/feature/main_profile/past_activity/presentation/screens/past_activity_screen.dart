import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../../core/ui/widget/shared_app_bar.dart';
import '../providers/past_activity_provider.dart';
import '../../domain/entities/past_meeting.dart';
import '../../domain/entities/ai_summary.dart';

// 과거 활동 내역 화면
class PastActivityScreen extends ConsumerStatefulWidget {
  const PastActivityScreen({super.key});

  @override
  ConsumerState<PastActivityScreen> createState() =>
      _PastActivityScreenState();
}

class _PastActivityScreenState extends ConsumerState<PastActivityScreen> {
  int _selectedTabIndex = 0;
  int _currentPage = 0;
  final int _pageSize = 10;
  final _numberFormat = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SharedAppBar(
        showBackButton: false,
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
          _buildTabs(),
          Expanded(
            child: _selectedTabIndex == 0
                ? _buildParticipantView()
                : _buildHostView(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

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

  Widget _buildTabItem(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
            _currentPage = 0;
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

  Widget _buildParticipantView() {
    // ✅ 백엔드 API 연동 - 과거 참여 내역
    final participatedMeetingsAsync = ref.watch(
      FutureProvider((ref) async {
        final useCase = ref.watch(getParticipatedMeetingsUseCaseProvider);
        return await useCase(page: _currentPage, size: _pageSize);
      }),
    );

    return participatedMeetingsAsync.when(
      data: (paginatedMeetings) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AI 요약은 백엔드 API가 없어서 에러 메시지 표시
              _buildSectionTitle('AI 요약'),
              _buildApiNotAvailableCard('AI 요약 API가 아직 준비되지 않았습니다.'),
              const SizedBox(height: 32),
              _buildSectionTitle(
                  '참여한 모임 (${paginatedMeetings.totalElements}건)'),
              if (paginatedMeetings.content.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text('참여한 모임이 없습니다.'),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paginatedMeetings.content.length,
                  itemBuilder: (context, index) {
                    return _buildMeetingCard(
                        paginatedMeetings.content[index] as PastMeeting);
                  },
                ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                '데이터 로드 실패',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHostView() {
    // ⚠️ 백엔드 API가 없어서 에러 메시지 표시
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.construction, size: 64, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              '호스트 기능 준비 중',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              '백엔드 API 엔드포인트가 아직 준비되지 않았습니다.\n'
              '백엔드 팀에 다음 API 추가 요청이 필요합니다:\n\n'
              'GET /api/me/meetings/hosted',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildApiNotAvailableCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.orange.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMeetingCard(PastMeeting meeting) {
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
            Text(meeting.date, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: meeting.imageUrl != null
                      ? Image.network(
                          meeting.imageUrl!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholderImage();
                          },
                        )
                      : _buildPlaceholderImage(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '[${meeting.location}] ${meeting.title}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_numberFormat.format(meeting.price)}원 · ${meeting.currentParticipants}명/${meeting.maxParticipants}명',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                _buildStatusChip(meeting.status),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      width: 60,
      height: 60,
      color: Colors.grey[200],
      child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    );
  }

  Widget _buildStatusChip(String status) {
    String text;
    Color color;
    switch (status.toLowerCase()) {
      case 'approved':
        text = '참여 승인';
        color = Colors.green;
        break;
      case 'pending':
        text = '승인 대기';
        color = Colors.orange;
        break;
      case 'completed':
        text = '참여 완료';
        color = Colors.grey;
        break;
      default:
        text = status;
        color = Colors.grey;
    }
    return Text(text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold));
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: const Color(0xBC37A23C),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border), label: 'Saved'),
        BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none), label: 'Alerts'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      onTap: (index) {
        print('Tapped item $index');
      },
    );
  }
}
