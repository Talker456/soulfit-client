import 'package:flutter/material.dart';
import 'readonly_green_box.dart';

class AnswerTextarea extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  final String hintText;
  final String? Function(String?)? validator;

  const AnswerTextarea({
    super.key,
    required this.controller,
    this.maxLines = 4,
    this.hintText = '답변을 입력해주세요.',
    this.validator,
  });

  OutlineInputBorder _greenBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: const BorderSide(color: kSoulfitGreen, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.35)),
        enabledBorder: _greenBorder(),
        focusedBorder: _greenBorder(),
      ),
      validator:
          validator ??
          (v) => (v == null || v.trim().isEmpty) ? '답변을 입력해주세요.' : null,
    );
  }
}
