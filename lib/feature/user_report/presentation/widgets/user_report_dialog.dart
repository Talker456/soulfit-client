// lib/feature/user_report/presentation/widgets/user_report_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/user_report_provider.dart';

class UserReportDialog extends ConsumerStatefulWidget {
  final String reporterUserId;
  final String reportedUserId;

  const UserReportDialog({
    super.key,
    required this.reporterUserId,
    required this.reportedUserId,
  });

  @override
  ConsumerState<UserReportDialog> createState() => _UserReportDialogState();
}

class _UserReportDialogState extends ConsumerState<UserReportDialog> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitReport() async {
    final notifier = ref.read(userReportProvider.notifier);

    await notifier.reportUser(
      reporterUserId: widget.reporterUserId,
      reportedUserId: widget.reportedUserId,
      reason: _reasonController.text,
    );

    final state = ref.read(userReportProvider);
    if (state is AsyncData) {
      if (mounted) Navigator.of(context).pop(); // 성공 시 다이얼로그 닫기
    } else if (state is AsyncError) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('신고에 실패했습니다. 다시 시도해주세요.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userReportProvider);

    return AlertDialog(
      title: const Text('신고하기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('신고 사유를 입력해주세요.'),
          const SizedBox(height: 12),
          TextField(
            controller: _reasonController,
            maxLines: 4,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: '예: 부적절한 언행, 사기 등',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        ElevatedButton(
          onPressed: state is AsyncLoading ? null : _submitReport,
          child:
              state is AsyncLoading
                  ? const CircularProgressIndicator()
                  : const Text('신고하기'),
        ),
      ],
    );
  }
}
