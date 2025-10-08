
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/ui/provider/main_profile_provider.dart';

class ConversationRequestDialog extends ConsumerStatefulWidget {
  final String targetUserId;

  const ConversationRequestDialog({super.key, required this.targetUserId});

  @override
  ConsumerState<ConversationRequestDialog> createState() =>
      _ConversationRequestDialogState();
}

class _ConversationRequestDialogState
    extends ConsumerState<ConversationRequestDialog> {
  final _messageController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendRequest() async {
    if (_messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('메시지를 입력해주세요.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final error = await ref
        .read(mainProfileNotifierProvider.notifier)
        .sendConversationRequest(
          toUserId: int.parse(widget.targetUserId),
          message: _messageController.text,
        );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop(); // Close the dialog
      if (error == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('대화 신청을 보냈습니다.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('오류: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('대화 신청하기'),
      content: TextField(
        controller: _messageController,
        decoration: const InputDecoration(
          hintText: '프로필을 보고 연락드렸습니다.',
          border: OutlineInputBorder(),
        ),
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('취소'),
        ),
        _isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _sendRequest,
                child: const Text('보내기'),
              ),
      ],
    );
  }
}
