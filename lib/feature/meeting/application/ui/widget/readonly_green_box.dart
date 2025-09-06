import 'package:flutter/material.dart';

const kSoulfitGreen = Color(0xFF2ECC71);
const kRadius = 10.0;

class ReadonlyGreenBox extends StatelessWidget {
  final String text;
  final String hint;
  final int maxLines;
  const ReadonlyGreenBox({
    super.key,
    required this.text,
    this.hint = '',
    this.maxLines = 4,
  });

  OutlineInputBorder _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(kRadius),
    borderSide: const BorderSide(color: kSoulfitGreen, width: 2),
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      readOnly: true,
      maxLines: maxLines,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        hintText: hint.isEmpty ? null : hint,
        hintStyle: TextStyle(color: kSoulfitGreen.withOpacity(0.6)),
        enabledBorder: _border(),
        focusedBorder: _border(),
        disabledBorder: _border(),
      ),
      style: const TextStyle(height: 1.4),
    );
  }
}
