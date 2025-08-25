import 'package:flutter/material.dart';

// 각 모임의 데이터를 담을 모델 클래스입니다.
class Group {
  final String title;
  final String description;
  final String location;
  final String date;
  final int currentMembers;
  final int maxMembers;
  final String imageUrl;

  // const 생성자가 아니므로, 이 클래스의 인스턴스는 컴파일 타임 상수가 될 수 없습니다.
  Group({
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.currentMembers,
    required this.maxMembers,
    required this.imageUrl,
  });
}

class GroupScreen extends StatelessWidget {
  // 예시용 더미 데이터 목록입니다. final이지만 const는 아닙니다.
  final List<Group> groups = [
    Group(
      title: '주말 한강 치맥 모임',
      description: '토요일 저녁, 시원한 강바람 맞으며 치맥하실 분들 모여요!',
      location: '여의나루역 근처',
      date: '7월 26일 (토) 18:00',
      currentMembers: 5,
      maxMembers: 10,
      imageUrl: 'https://placehold.co/600x400/FFDDC1/333333?text=Chimaek',
    ),
    Group(
      title: '플러터 초보 스터디',
      description: '클린 아키텍처, Riverpod 같이 공부해요. 매주 온라인으로 진행합니다.',
      location: '온라인 (디스코드)',
      date: '매주 일요일 20:00',
      currentMembers: 3,
      maxMembers: 5,
      imageUrl: 'https://placehold.co/600x400/A2E9F0/333333?text=Flutter',
    ),
    Group(
      title: '퇴근 후 보드게임 한판!',
      description: '강남역 근처 보드게임 카페에서 같이 놀아요. 처음이신 분도 대환영!',
      location: '강남역 보드게임 카페',
      date: '7월 24일 (목) 19:30',
      currentMembers: 2,
      maxMembers: 4,
      imageUrl: 'https://placehold.co/600x400/D4F0F0/333333?text=Board+Game',
    ),
  ];

  GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('모임'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          // _buildGroupCard 메서드를 호출합니다.
          return _buildGroupCard(context, group);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('새 모임 만들기 버튼 클릭!');
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  // 각 모임 카드를 만드는 private 메서드
  Widget _buildGroupCard(BuildContext context, Group group) {
    // Card 위젯에서 const를 제거했습니다.
    // 왜냐하면 이 Card는 변수인 'group'의 데이터를 사용하기 때문입니다.
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            group.imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error, color: Colors.red, size: 40),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  group.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                _buildInfoRow(Icons.location_on, group.location),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.calendar_today, group.date),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.groups,
                    '${group.currentMembers} / ${group.maxMembers} 명'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: () {
                print('${group.title} 참여하기 클릭!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                '참여하기',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 아이콘과 텍스트를 한 줄에 보여주는 작은 위젯
  Widget _buildInfoRow(IconData icon, String text) {
    // 이 위젯도 변수인 'text'를 사용하므로 const가 될 수 없습니다.
    return Row(
      children: [
        Icon(icon, color: Colors.grey[500], size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }
}


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupScreen(),
    ),
  );
}