// widget/section_reviews.dart
import 'package:flutter/material.dart';
import '../state/meeting_post_state.dart';

class SectionReviews extends StatelessWidget {
  final int count;
  final double avg;
  final String summary;
  final List<MPReview> items;
  const SectionReviews({
    super.key,
    required this.count,
    required this.avg,
    required this.summary,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '리뷰 $count개 ★${avg.toStringAsFixed(1)}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: summary),
          minLines: 2,
          maxLines: 4,
          readOnly: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 8),
        OutlinedButton(onPressed: () {}, child: const Text('리뷰 전체 보기')),
        const SizedBox(height: 8),
        ...items.map(
          (r) => Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text('${r.author}  ★${r.rating}'),
              subtitle: Text(r.content),
            ),
          ),
        ),
      ],
    );
  }
}
