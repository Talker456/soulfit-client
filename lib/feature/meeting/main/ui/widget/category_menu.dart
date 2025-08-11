import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryMenu extends StatelessWidget {
  const CategoryMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'icon': Icons.flight_takeoff, 'label': '여행'},
      {'icon': Icons.book, 'label': '스터디'},
      {'icon': Icons.celebration, 'label': '파티'},
      {'icon': Icons.sports_esports, 'label': '취미'},
    ];

    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = categories[index];
          final label = item['label'] as String;
          return InkWell(
            onTap: () {
              // TODO: 라우팅 경로 AppRoutes에 상수로 정의하기
              context.push('/meeting-list/$label');
            },
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item['icon'] as IconData, color: Colors.black),
                ),
                const SizedBox(height: 4),
                Text(label),
              ],
            ),
          );
        },
      ),
    );
  }
}
