import 'package:flutter/material.dart';

class SurveyOptionButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final Color selectedColor;
  final Color unselectedColor;
  final Color selectedTextColor;
  final Color unselectedTextColor;

  const SurveyOptionButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    required this.selectedColor,
    required this.unselectedColor,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? selectedColor : unselectedColor,
          foregroundColor: isSelected ? selectedTextColor : unselectedTextColor,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
