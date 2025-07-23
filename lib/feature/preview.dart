import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/test_result_report.dart';

void main() {
  runApp(const SoulfitApp());
}

class SoulfitApp extends StatelessWidget {
  const SoulfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnalysisReportScreen(report: dummyReport),
    );
  }
}