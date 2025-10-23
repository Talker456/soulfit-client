import 'package:flutter/material.dart';

class MonthlyActivityChart extends StatelessWidget {
  final Map<String, int> monthlyActivity;

  const MonthlyActivityChart({super.key, required this.monthlyActivity});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final entries = monthlyActivity.entries.toList();

    if (entries.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const SizedBox(
          height: 200,
          child: Center(child: Text('활동 데이터 없음')),
        ),
      );
    }

    // Determine max value for scaling
    final maxValue = entries.map((e) => e.value).reduce((a, b) => a > b ? a : b).toDouble();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('월별 활동', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: _BarChartPainter(entries, maxValue, theme.primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: entries.map((entry) {
                    final month = entry.key.split('-').last;
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${entry.value}', style: theme.textTheme.bodySmall),
                          const SizedBox(height: 4),
                          Text('${month}월', style: theme.textTheme.bodySmall),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<MapEntry<String, int>> entries;
  final double maxValue;
  final Color barColor;

  _BarChartPainter(this.entries, this.maxValue, this.barColor);

  @override
  void paint(Canvas canvas, Size size) {
    final barWidth = size.width / entries.length / 2; // Half width for bar, half for space
    final paint = Paint()
      ..color = barColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final barHeight = (entry.value / maxValue) * size.height;
      final left = i * (size.width / entries.length) + barWidth / 2;
      final top = size.height - barHeight;
      final right = left + barWidth;
      final bottom = size.height;

      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter oldDelegate) {
    return oldDelegate.entries != entries || oldDelegate.maxValue != maxValue || oldDelegate.barColor != barColor;
  }
}
