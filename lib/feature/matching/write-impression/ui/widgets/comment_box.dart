import 'package:flutter/material.dart';

class CommentBox extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final int maxLen;
  const CommentBox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.maxLen,
  });

  @override
  Widget build(BuildContext context) {
    final count = value.characters.length;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEEF5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            minLines: 3,
            maxLines: 5,
            maxLength: maxLen,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: '상대방에 대한 후기를 작성해주세요 (최대 150자)',
              counterText: '',
            ),
            onChanged: onChanged,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$count/$maxLen',
              style: const TextStyle(color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
