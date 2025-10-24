import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final Widget child;

  const ProfileCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5), // 연한 핑크 배경
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFC1D5), width: 5), // 진한 핑크 테두리
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // 테두리 안쪽으로 child가 잘리도록
        child: child,
      ),
    );
  }
}
