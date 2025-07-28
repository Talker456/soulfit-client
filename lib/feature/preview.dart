import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/host_history_group_list.dart';

void main() {
  runApp(const SoulfitApp());
}

class SoulfitApp extends StatelessWidget {
  const SoulfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HostHistoryGroupList(events: dummyHostedEvents, hostName: '소울핏'),
    );
  }
}