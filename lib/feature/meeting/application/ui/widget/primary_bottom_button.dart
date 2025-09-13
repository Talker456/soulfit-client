import 'package:flutter/material.dart';
import 'readonly_green_box.dart';

class PrimaryBottomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const PrimaryBottomButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          const Spacer(),
          SizedBox(
            height: 44,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: kSoulfitGreen,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              onPressed: onPressed,
              child: Text(label),
            ),
          ),
        ],
      ),
    );
  }
}
