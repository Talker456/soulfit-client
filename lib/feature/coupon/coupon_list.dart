import 'package:flutter/material.dart';

// 각 쿠폰의 데이터를 담을 모델 클래스입니다.
class Coupon {
  final String title;
  final String description;
  final String expiryDate;
  final bool isUsed;

  Coupon({
    required this.title,
    required this.description,
    required this.expiryDate,
    this.isUsed = false,
  });
}

class CouponList extends StatelessWidget {
  // 예시용 더미 데이터 목록입니다.
  final List<Coupon> coupons = [
    Coupon(
      title: '첫 만남 응원 10% 할인 쿠폰',
      description: '소개팅 서비스 결제 시 사용 가능',
      expiryDate: '2025-12-31까지',
    ),
    Coupon(
      title: '모임 개설 축하 쿠폰',
      description: '모임 홍보 아이템 구매 시 2,000원 할인',
      expiryDate: '2025-08-31까지',
    ),
  ];

  CouponList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 쿠폰 등록 섹션 ---
            const Text(
              '쿠폰 등록',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildCouponRegisterField(), // 쿠폰 입력창과 버튼
            const SizedBox(height: 24),
            const Divider(), // 구분선
            const SizedBox(height: 24),

            // --- 내 쿠폰 목록 섹션 ---
            const Text(
              '내 쿠폰',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Expanded를 사용해 남은 공간을 쿠폰 목록으로 모두 채웁니다.
            Expanded(
              child: ListView.builder(
                itemCount: coupons.length,
                itemBuilder: (context, index) {
                  final coupon = coupons[index];
                  // 각 쿠폰을 카드 형태로 보여주는 위젯
                  return _buildCouponCard(coupon);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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
      ),
    );
  }

  // 쿠폰 입력창과 등록 버튼을 만드는 위젯
  Widget _buildCouponRegisterField() {
    return Row(
      children: [
        // Expanded를 사용해 입력창이 가능한 많은 공간을 차지하게 합니다.
        const Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: '쿠폰 코드를 입력하세요',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 등록 버튼
        ElevatedButton(
          onPressed: () {
            print('쿠폰 등록 버튼 클릭!');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('등록', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // 각 쿠폰 카드를 만드는 위젯
  Widget _buildCouponCard(Coupon coupon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: coupon.isUsed ? Colors.grey[300] : const Color(0xFFF5FFF5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: coupon.isUsed ? Colors.grey[400]! : const Color(0xFF79C72B),
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              coupon.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: coupon.isUsed ? Colors.grey[600] : Colors.black,
                // 사용된 쿠폰은 취소선 효과
                decoration: coupon.isUsed ? TextDecoration.lineThrough : null,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              coupon.description,
              style: TextStyle(
                fontSize: 14,
                color: coupon.isUsed ? Colors.grey[600] : Colors.black54,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '유효기간: ${coupon.expiryDate}',
              style: TextStyle(
                fontSize: 12,
                color: coupon.isUsed ? Colors.grey[600] : Colors.red[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CouponList(),
    ),
  );
}