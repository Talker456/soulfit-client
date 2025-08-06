import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateRangeFilterModal extends ConsumerStatefulWidget {
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;

  const DateRangeFilterModal({super.key, this.initialStartDate, this.initialEndDate});

  @override
  ConsumerState<DateRangeFilterModal> createState() => _DateRangeFilterModalState();
}

class _DateRangeFilterModalState extends ConsumerState<DateRangeFilterModal> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: (_startDate != null && _endDate != null)
          ? DateTimeRange(start: _startDate!, end: _endDate!)
          : null,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '일정 선택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(
              _startDate == null && _endDate == null
                  ? '날짜 범위 선택'
                  : '${_startDate != null ? dateFormat.format(_startDate!) : ''} ~ ${_endDate != null ? dateFormat.format(_endDate!) : ''}',
            ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () => _selectDateRange(context),
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
                  Navigator.pop(context, {'startDate': _startDate, 'endDate': _endDate}); // 선택된 날짜 범위 반환
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
