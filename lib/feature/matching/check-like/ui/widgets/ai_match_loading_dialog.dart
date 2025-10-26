import 'package:flutter/material.dart';

class AiMatchLoadingDialog extends StatelessWidget {
  const AiMatchLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('AI 매칭 분석 중...'),
        ],
      ),
    );
  }
}
