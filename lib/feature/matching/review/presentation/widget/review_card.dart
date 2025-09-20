
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/matching/review/domain/entity/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review.reviewer.nickname,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${review.createdAt.year}-${review.createdAt.month}-${review.createdAt.day}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review.comment),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: review.keywords
                  .map((keyword) => Chip(label: Text(keyword)))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
