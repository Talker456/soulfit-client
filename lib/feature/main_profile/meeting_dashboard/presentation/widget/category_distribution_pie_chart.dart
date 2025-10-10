import 'dart:math';
import 'package:flutter/material.dart';

class CategoryDistributionPieChart extends StatelessWidget {
  final Map<String, int> categoryDistribution;

  const CategoryDistributionPieChart({super.key, required this.categoryDistribution});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = categoryDistribution.values.fold(0, (a, b) => a + b);
    final entries = categoryDistribution.entries.toList();

    if (entries.isEmpty || total == 0) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: const SizedBox(
          height: 250,
          child: Center(child: Text('카테고리 데이터 없음')),
        ),
      );
    }

    // Predefined colors for consistency
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.brown,
      Colors.indigo,
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('카테고리 분포', style: theme.textTheme.titleMedium),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: CustomPaint(
                painter: _PieChartPainter(entries, total, colors),
                child: Center(
                  child: Text(
                    '${total}개',
                    style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: List.generate(entries.length, (i) {
                return _Indicator(color: colors[i % colors.length], text: entries[i].key);
              }),
            )
          ],
        ),
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final List<MapEntry<String, int>> entries;
  final int total;
  final List<Color> colors;

  _PieChartPainter(this.entries, this.total, this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 3);
    double startAngle = -pi / 2; // Start from top

    for (int i = 0; i < entries.length; i++) {
      final entry = entries[i];
      final sweepAngle = (entry.value / total) * 2 * pi;
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant _PieChartPainter oldDelegate) {
    return oldDelegate.entries != entries || oldDelegate.total != total || oldDelegate.colors != colors;
  }
}

class _Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const _Indicator({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12))
      ],
    );
  }
}
