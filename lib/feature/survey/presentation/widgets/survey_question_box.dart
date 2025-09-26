import 'package:flutter/material.dart';

class SurveyQuestionBox extends StatelessWidget {
  final String questionText;
  final Color borderColor;
  final Color textColor;

  const SurveyQuestionBox({
    super.key,
    required this.questionText,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Text(
        questionText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
