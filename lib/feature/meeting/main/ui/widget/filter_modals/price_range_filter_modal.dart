import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PriceRangeFilterModal extends ConsumerStatefulWidget {
  final double? initialMinPrice;
  final double? initialMaxPrice;

  const PriceRangeFilterModal({super.key, this.initialMinPrice, this.initialMaxPrice});

  @override
  ConsumerState<PriceRangeFilterModal> createState() => _PriceRangeFilterModalState();
}

class _PriceRangeFilterModalState extends ConsumerState<PriceRangeFilterModal> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      widget.initialMinPrice ?? 0,
      widget.initialMaxPrice ?? 100000,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'ko_KR', symbol: '원');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '가격 범위 선택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currencyFormat.format(_currentRangeValues.start)),
              Text(currencyFormat.format(_currentRangeValues.end)),
            ],
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 0,
            max: 100000,
            divisions: 100,
            labels: RangeLabels(
              currencyFormat.format(_currentRangeValues.start),
              currencyFormat.format(_currentRangeValues.end),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
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
                  Navigator.pop(context, {
                    'minPrice': _currentRangeValues.start,
                    'maxPrice': _currentRangeValues.end,
                  }); // 선택된 가격 범위 반환
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
