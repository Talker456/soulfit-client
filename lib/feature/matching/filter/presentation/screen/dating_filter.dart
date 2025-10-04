import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import '../../domain/entities/dating_filter.dart';
import '../riverpod/dating_filter_provider.dart';

// --- 화면을 그리는 메인 위젯 ---
class DatingFilterScreen extends ConsumerWidget {
  const DatingFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(datingFilterProvider);
    final filterNotifier = ref.read(datingFilterProvider.notifier);
    final filteredUsersNotifier = ref.read(filteredUsersProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, filterNotifier),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLocationPicker(filter.location, filterNotifier),
                    const SizedBox(height: 32),
                    _buildRangeSlider(
                      '키',
                      RangeValues(filter.minHeight, filter.maxHeight),
                      140,
                      200,
                      (values) => filterNotifier.updateHeightRange(values.start, values.end),
                    ),
                    const SizedBox(height: 32),
                    _buildSingleSlider(
                      '거리',
                      filter.distance,
                      0,
                      400,
                      (value) => filterNotifier.updateDistance(value),
                    ),
                    const SizedBox(height: 32),
                    _buildRangeSlider(
                      '나이',
                      RangeValues(filter.minAge.toDouble(), filter.maxAge.toDouble()),
                      19,
                      50,
                      (values) => filterNotifier.updateAgeRange(values.start.round(), values.end.round()),
                    ),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '흡연',
                      SmokingType.values.map((e) => e.displayName).toList(),
                      filter.smokingPreference?.index,
                      (index) => filterNotifier.updateSmokingPreference(
                        index != null ? SmokingType.values[index] : null,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '음주',
                      DrinkingType.values.map((e) => e.displayName).toList(),
                      filter.drinkingPreference?.index,
                      (index) => filterNotifier.updateDrinkingPreference(
                        index != null ? DrinkingType.values[index] : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildSearchButton(context, filter, filterNotifier, filteredUsersNotifier),
          ],
        ),
      ),
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
  Widget _buildHeader(BuildContext context, dynamic filterNotifier) {
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
                onPressed: () => filterNotifier.resetToDefault(),
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
  Widget _buildLocationPicker(String selectedLocation, dynamic filterNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('지역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () {
            // TODO: 지역 선택 다이얼로그 구현
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
                Text(selectedLocation, style: const TextStyle(fontSize: 16)),
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
  Widget _buildSearchButton(
    BuildContext context,
    dynamic filter,
    dynamic filterNotifier,
    dynamic filteredUsersNotifier,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          await filterNotifier.saveCurrentFilter();
          await filteredUsersNotifier.searchWithFilter(filter);

          if (context.mounted) {
            Navigator.of(context).pop();
          }
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
    ProviderScope(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DatingFilterScreen(),
      ),
    ),
  );
}
