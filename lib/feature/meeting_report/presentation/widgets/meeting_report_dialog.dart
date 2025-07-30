// lib/feature/meeting_report/presentation/widgets/meeting_report_dialog.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/meeting_report_provider.dart';

class MeetingReportDialog extends ConsumerStatefulWidget {
  final String reporterUserId;
  final String meetingId;

  const MeetingReportDialog({
    super.key,
    required this.reporterUserId,
    required this.meetingId,
  });

  @override
  ConsumerState<MeetingReportDialog> createState() =>
      _MeetingReportDialogState();
}

class _MeetingReportDialogState extends ConsumerState<MeetingReportDialog> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitReport() async {
    final notifier = ref.read(meetingReportProvider.notifier);

    await notifier.reportMeeting(
      reporterUserId: widget.reporterUserId,
      meetingId: widget.meetingId,
      reason: _reasonController.text,
    );

    final state = ref.read(meetingReportProvider);
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
    final state = ref.watch(meetingReportProvider);

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
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '예: 부적절한 모임 운영, 허위 정보 등',
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
                  ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text('신고하기'),
        ),
      ],
    );
  }
}
