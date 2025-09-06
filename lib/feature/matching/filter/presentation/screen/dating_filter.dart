import 'package:flutter/material.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';

// --- 화면을 그리는 메인 위젯 ---
class DatingFilter extends StatefulWidget {
  const DatingFilter({super.key});

  @override
  State<DatingFilter> createState() => _DatingFilterState();
}

class _DatingFilterState extends State<DatingFilter> {
  // --- 1. 각 필터의 값을 저장하고 관리하기 위한 변수들 ---
  String _selectedLocation = '한국';
  RangeValues _heightRange = const RangeValues(160, 180);
  double _distance = 40;
  RangeValues _ageRange = const RangeValues(20, 30);
  int? _smokingChoice; // 0: 흡연자, 1: 비흡연자
  int? _drinkingChoice; // 0: 자주, 1: 종종, 2: 안 마셔요

  // 모든 필터 값을 초기화하는 함수
  void _resetFilters() {
    setState(() {
      _selectedLocation = '한국';
      _heightRange = const RangeValues(160, 180);
      _distance = 40;
      _ageRange = const RangeValues(20, 30);
      _smokingChoice = null;
      _drinkingChoice = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea( // 상단 상태바 영역을 침범하지 않도록 SafeArea 사용
        child: Column(
          children: [
            // --- 2. AppBar 대신 직접 만드는 상단 헤더 ---
            _buildHeader(),
            // Expanded와 SingleChildScrollView를 사용해 내용만 스크롤되도록 구현
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- 필터 섹션들 ---
                    _buildLocationPicker(),
                    const SizedBox(height: 32),
                    _buildRangeSlider('키', _heightRange, 140, 200, (values) {
                      setState(() => _heightRange = values);
                    }),
                    const SizedBox(height: 32),
                    _buildSingleSlider('거리', _distance, 0, 400, (value) {
                      setState(() => _distance = value);
                    }),
                    const SizedBox(height: 32),
                    _buildRangeSlider('나이', _ageRange, 19, 50, (values) {
                      setState(() => _ageRange = values);
                    }),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '흡연',
                      ['흡연자', '비흡연자'],
                      _smokingChoice,
                      (index) => setState(() => _smokingChoice = index),
                    ),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '음주',
                      ['자주 마셔요', '종종 마셔요', '안 마셔요'],
                      _drinkingChoice,
                      (index) => setState(() => _drinkingChoice = index),
                    ),
                  ],
                ),
              ),
            ),
            // --- 3. 하단 검색 버튼 ---
            _buildSearchButton(),
          ],
        ),
      ),
      // --- 바로 이 부분입니다! SharedNavigationBar를 추가했습니다. ---
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          // TODO: 탭 처리 구현
        },
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 상단 헤더 (뒤로가기, 제목, 초기화 버튼)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 16, 8),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, size: 32),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                onPressed: _resetFilters,
                child: const Text('초기화', style: TextStyle(color: Colors.pinkAccent, fontSize: 16)),
              ),
            ],
          ),
          const Text('필터', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 지역 선택 버튼
  Widget _buildLocationPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('지역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            print('지역 선택 팝업 띄우기!');
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedLocation, style: const TextStyle(fontSize: 16)),
                const Icon(Icons.chevron_right, color: Colors.pinkAccent),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 범위 슬라이더 (키, 나이)
  Widget _buildRangeSlider(String title, RangeValues values, double min, double max, ValueChanged<RangeValues> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${values.start.round()}-${values.end.round()}', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        RangeSlider(
          values: values,
          min: min,
          max: max,
          activeColor: Colors.pinkAccent,
          inactiveColor: Colors.pink.shade50,
          onChanged: onChanged,
        ),
      ],
    );
  }

  // 단일 슬라이더 (거리)
  Widget _buildSingleSlider(String title, double value, double min, double max, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${value.round()}km', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          activeColor: Colors.pinkAccent,
          inactiveColor: Colors.pink.shade50,
          onChanged: onChanged,
        ),
      ],
    );
  }
  
  // 선택 칩 섹션 (흡연, 음주)
  Widget _buildChoiceChipSection(String title, List<String> choices, int? groupValue, ValueChanged<int?> onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12.0,
          children: List<Widget>.generate(choices.length, (int index) {
            return ChoiceChip(
              label: Text(choices[index]),
              selected: groupValue == index,
              onSelected: (bool selected) {
                onSelected(selected ? index : null);
              },
              selectedColor: Colors.pink.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: groupValue == index ? Colors.pinkAccent : Colors.grey.shade300,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // 하단 검색 버튼
  Widget _buildSearchButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          print('--- 검색 필터 값 ---');
          print('지역: $_selectedLocation');
          print('키: ${_heightRange.start.round()}-${_heightRange.end.round()}');
          print('거리: ${_distance.round()}km');
          print('나이: ${_ageRange.start.round()}-${_ageRange.end.round()}');
          print('흡연: $_smokingChoice');
          print('음주: $_drinkingChoice');
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.pinkAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          '검색',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  } 
}

// --- 이 파일을 독립적으로 실행하기 위한 main 함수 ---
void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatingFilter(),
    ),
  );
}
