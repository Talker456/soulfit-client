import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionFilterModal extends ConsumerStatefulWidget {
  final String? initialRegion;

  const RegionFilterModal({super.key, this.initialRegion});

  @override
  ConsumerState<RegionFilterModal> createState() => _RegionFilterModalState();
}

class _RegionFilterModalState extends ConsumerState<RegionFilterModal> {
  String? _selectedRegion;

  @override
  void initState() {
    super.initState();
    _selectedRegion = widget.initialRegion;
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
            '지역 선택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8.0,
            children: [
              _buildRegionChip(context, '서울'),
              _buildRegionChip(context, '부산'),
              _buildRegionChip(context, '대구'),
              _buildRegionChip(context, '인천'),
              _buildRegionChip(context, '광주'),
              _buildRegionChip(context, '대전'),
              _buildRegionChip(context, '울산'),
              _buildRegionChip(context, '세종'),
              _buildRegionChip(context, '경기'),
              _buildRegionChip(context, '강원'),
              _buildRegionChip(context, '충북'),
              _buildRegionChip(context, '충남'),
              _buildRegionChip(context, '전북'),
              _buildRegionChip(context, '전남'),
              _buildRegionChip(context, '경북'),
              _buildRegionChip(context, '경남'),
              _buildRegionChip(context, '제주'),
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
                  Navigator.pop(context, _selectedRegion); // 선택된 지역 반환
                },
                child: const Text('적용'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionChip(BuildContext context, String region) {
    final isSelected = _selectedRegion == region;
    return ChoiceChip(
      label: Text(region),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedRegion = selected ? region : null;
        });
      },
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).primaryColor : Colors.black,
      ),
    );
  }
}
