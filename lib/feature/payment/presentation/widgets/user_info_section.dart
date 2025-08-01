import 'package:flutter/material.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // 프로필 이미지
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300],
            ),
            child: const Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(width: 12),
          // 이름, 이메일
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '이름',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text('이메일', style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
