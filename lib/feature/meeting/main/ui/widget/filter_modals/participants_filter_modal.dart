import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticipantsFilterModal extends ConsumerStatefulWidget {
  final int? initialMinParticipants;
  final int? initialMaxParticipants;

  const ParticipantsFilterModal({super.key, this.initialMinParticipants, this.initialMaxParticipants});

  @override
  ConsumerState<ParticipantsFilterModal> createState() => _ParticipantsFilterModalState();
}

class _ParticipantsFilterModalState extends ConsumerState<ParticipantsFilterModal> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      (widget.initialMinParticipants ?? 1).toDouble(),
      (widget.initialMaxParticipants ?? 100).toDouble(),
    );
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
            '인원수 범위 선택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_currentRangeValues.start.round()}명'),
              Text('${_currentRangeValues.end.round()}명'),
            ],
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 1,
            max: 100,
            divisions: 99,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
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
                    'minParticipants': _currentRangeValues.start.round(),
                    'maxParticipants': _currentRangeValues.end.round(),
                  }); // 선택된 인원수 범위 반환
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
