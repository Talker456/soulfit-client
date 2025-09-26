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
    double progress = totalSteps > 0 ? (currentStep + 1) / totalSteps : 0;

    return Container(
      width: 100, // Fixed width for the progress bar
      height: 8,  // Height of the progress bar
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
