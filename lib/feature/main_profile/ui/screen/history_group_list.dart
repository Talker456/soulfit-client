import 'package:flutter/material.dart';

// --- 1. 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---
// 각 모임의 정보를 담는 구조입니다.
class HostedEvent {
  final String date;
  final String title;
  final String location;
  final int price;
  final int currentParticipants;
  final int maxParticipants;
  final String imageUrl;

  HostedEvent({
    required this.date,
    required this.title,
    required this.location,
    required this.price,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.imageUrl,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
// 백엔드 API가 완성되기 전까지 이 가짜 데이터를 사용해서 UI를 만듭니다.
final List<HostedEvent> dummyHostedEvents = [
  HostedEvent(
    date: '2025.07.18',
    title: '거북 베이킹',
    location: '수원',
    price: 30000,
    currentParticipants: 6,
    maxParticipants: 8,
    imageUrl: 'https://placehold.co/100x100/A2E9F0/333333?text=🐢',
  ),
  HostedEvent(
    date: '2025.06.25',
    title: '한강 나이트 워크',
    location: '서울',
    price: 15000,
    currentParticipants: 12,
    maxParticipants: 20,
    imageUrl: 'https://placehold.co/100x100/FFDDC1/333333?text=🏃‍♂️',
  ),
  HostedEvent(
    date: '2025.05.11',
    title: '나만의 향수 만들기',
    location: '홍대',
    price: 45000,
    currentParticipants: 8,
    maxParticipants: 8,
    imageUrl: 'https://placehold.co/100x100/D4F0F0/333333?text=💧',
  ),
  // 여기에 더 많은 모임 데이터를 추가할 수 있습니다.
];

// --- 3. 화면을 그리는 메인 위젯 ---
class HistoryGroupList extends StatelessWidget {
  // 실제 앱에서는 이 데이터를 외부(백엔드)에서 받아오게 됩니다.
  final List<HostedEvent> events= dummyHostedEvents;
  final String hostName;

  HistoryGroupList({
    super.key,
    // required this.events,
    this.hostName = 'OO', // 기본값 설정
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // soulfit 상단바
          AppBar(
            elevation: 0, 
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: const Text(
              'soulfit',
              style: TextStyle(
                color: Color(0xBC37A23C),
                fontSize: 28,
                fontFamily: 'Arima Madurai',
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
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
          // 기존 상단 AppBar (뒤로가기 + 타이틀)
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              '$hostName님이 주최한 모임',
              style: const TextStyle(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
          // 본문 리스트 (Expanded로 감싸기)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return _buildEventCard(event);
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드 ---

  // 각 모임 카드를 만드는 위젯
  Widget _buildEventCard(HostedEvent event) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: const Color(0x226BBA6F),
        onTap: () {
          // TODO: 상세 페이지 이동 등 원하는 동작 구현
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF6BBA6F), width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 날짜
                Text(
                  event.date,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                // 이미지와 상세 정보
                Row(
                  children: [
                    // 모임 대표 이미지
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        event.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 70,
                            height: 70,
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 상세 정보 (제목, 가격, 인원)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '[${event.location}] ${event.title}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${event.price}원 · ${event.currentParticipants}명/${event.maxParticipants}명',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
