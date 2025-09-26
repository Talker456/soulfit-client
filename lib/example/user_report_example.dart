// lib/example/user_report_example.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../feature/user_report/presentation/widgets/user_report_dialog.dart';

class UserReportExample extends StatelessWidget {
  const UserReportExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('신고 기능 테스트')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '사용자 신고 기능 테스트',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const UserReportDialog(
                    reporterUserId: 'current_user_123',
                    reportedUserId: 'reported_user_456',
                  ),
                );
              },
              child: const Text('사용자 신고하기'),
            ),
            const SizedBox(height: 20),
            const Text(
              '현재 FAKE_DATASOURCE를 사용 중입니다.\n'
              '실제 서버 연결을 위해서는\n'
              'provider.dart에서 USE_FAKE_DATASOURCE를\n'
              'false로 변경하세요.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// 사용법:
// 1. 앱에서 이 화면을 띄우거나
// 2. 직접 UserReportDialog를 사용하거나
// 3. Provider를 통해 직접 신고 기능 호출

class DirectReportExample extends ConsumerWidget {
  const DirectReportExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('직접 신고 예시')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final notifier = ref.read(
              // Note: import 경로는 실제 파일 구조에 따라 조정 필요
              // '../feature/user_report/presentation/riverpod/user_report_provider.dart'
              // 의 userReportProvider.notifier
            );

            try {
              // await notifier.reportUser(
              //   reporterUserId: 'current_user',
              //   reportedUserId: 'target_user',
              //   reason: '직접 호출 테스트',
              // );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('신고가 접수되었습니다.')),
              );
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('신고에 실패했습니다: $e')),
              );
            }
          },
          child: const Text('직접 신고 호출'),
        ),
      ),
    );
  }
}