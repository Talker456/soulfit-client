
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/user_report_provider.dart';

class UserReportDialog extends ConsumerStatefulWidget {
  final String reportedUserId;

  const UserReportDialog({
    super.key,
    required this.reportedUserId,
  });

  @override
  ConsumerState<UserReportDialog> createState() => _UserReportDialogState();
}

class _UserReportDialogState extends ConsumerState<UserReportDialog> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitReport() async {
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('신고 사유를 입력해주세요.')),
      );
      return;
    }

    try {
      await ref.read(userReportProvider.notifier).reportUser(
        reportedUserId: widget.reportedUserId,
        description: _descriptionController.text,
      );
      // The provider will handle the state, listen to it for UI changes.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('신고가 접수되었습니다.')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('신고에 실패했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(userReportProvider, (_, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('신고 처리 중 오류가 발생했습니다.')),
        );
      }
    });

    final state = ref.watch(userReportProvider);

    return AlertDialog(
      title: const Text('신고하기'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('신고 사유를 자세히 입력해주세요.'),
          const SizedBox(height: 12),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
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
          onPressed: state.isLoading ? null : _submitReport,
          child: state.isLoading
              ? const CircularProgressIndicator()
              : const Text('신고하기'),
        ),
      ],
    );
  }
}

