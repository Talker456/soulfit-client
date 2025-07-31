import 'package:flutter/material.dart';

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
          return Column(
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
              Text(item['label'] as String),
            ],
          );
        },
      ),
    );
  }
}
