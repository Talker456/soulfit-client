import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/ai_match.dart';

class AiMatchResultDialog extends StatelessWidget {
  final AiMatch matchResult;
  final String viewerId; // Add viewerId

  const AiMatchResultDialog({super.key, required this.matchResult, required this.viewerId}); // Update constructor

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AI 매칭 분석 결과'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(matchResult.profileImageUrl),
              onBackgroundImageError: (exception, stackTrace) {},
            ),
          ),
          const SizedBox(height: 16),
          Text('추천 사용자: ${matchResult.username}'),
          const SizedBox(height: 8),
          Text('매칭 점수: ${(matchResult.matchScore * 100).toStringAsFixed(1)}%'),
          const SizedBox(height: 8),
          const Text('매칭 이유:'),
          Text(matchResult.matchReason),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Dismiss dialog
            context.push('/dating-profile/$viewerId/${matchResult.userId}'); // Navigate to profile
          },
          child: const Text('프로필 보기'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('닫기'),
        ),
      ],
    );
  }
}
