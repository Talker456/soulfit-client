import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RatingFilterModal extends ConsumerStatefulWidget {
  final double? initialMinRating;

  const RatingFilterModal({super.key, this.initialMinRating});

  @override
  ConsumerState<RatingFilterModal> createState() => _RatingFilterModalState();
}

class _RatingFilterModalState extends ConsumerState<RatingFilterModal> {
  double _minRating = 0.0;

  @override
  void initState() {
    super.initState();
    _minRating = widget.initialMinRating ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '최소 평점 선택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _minRating,
                  min: 0.0,
                  max: 5.0,
                  divisions: 5,
                  label: _minRating.toStringAsFixed(1),
                  onChanged: (double value) {
                    setState(() {
                      _minRating = value;
                    });
                  },
                ),
              ),
              Text(_minRating.toStringAsFixed(1)),
              const Icon(Icons.star, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // 모달 닫기
                },
                child: const Text('취소'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {'minRating': _minRating}); // 선택된 최소 평점 반환
                },
                child: const Text('적용'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
