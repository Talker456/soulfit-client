import 'package:flutter/material.dart';

class SurveyProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color color;

  const SurveyProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: (currentStep + 1) / totalSteps,
      backgroundColor: Colors.grey.shade300,
      color: color,
      minHeight: 6,
    );
  }
}
