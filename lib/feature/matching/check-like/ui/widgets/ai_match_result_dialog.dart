import 'package:flutter/material.dart';
import '../../domain/entities/ai_match.dart';

class AiMatchResultDialog extends StatelessWidget {
  final AiMatch matchResult;

  const AiMatchResultDialog({super.key, required this.matchResult});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AI 매칭 분석 결과'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('사용자 ID: ${matchResult.userId}'),
          const SizedBox(height: 8),
          Text('매칭 점수: ${(matchResult.matchScore * 100).toStringAsFixed(1)}%'),
          const SizedBox(height: 8),
          const Text('매칭 이유:'),
          Text(matchResult.matchReason),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('닫기'),
        ),
      ],
    );
  }
}
