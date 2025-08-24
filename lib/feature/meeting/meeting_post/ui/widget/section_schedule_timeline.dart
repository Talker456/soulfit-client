// widget/section_schedule_timeline.dart
import 'package:flutter/material.dart';
import '../state/meeting_post_state.dart';

class SectionScheduleTimeline extends StatelessWidget {
  final List<MPSchedule> schedules;
  const SectionScheduleTimeline({super.key, required this.schedules});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          schedules.map((s) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 32,
                      color: Colors.green.shade200,
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Text('${s.timeRange}   ${s.title}'),
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }
}
