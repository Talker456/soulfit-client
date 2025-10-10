import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import '../../domain/entities/dating_filter.dart';
import '../provider/dating_filter_provider.dart';
import '../riverpod/dating_filter_riverpod.dart';

// --- 화면을 그리는 메인 위젯 ---
class DatingFilterScreen extends ConsumerWidget {
  const DatingFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(datingFilterProvider);
    final filterNotifier = ref.read(datingFilterProvider.notifier);
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
                    // _buildLocationPicker(filterState.filter.region, filterNotifier), // Removed as per user request
                    // const SizedBox(height: 32),
                    _buildSingleSlider(
                      '거리',
                      filterState.filter.maxDistanceInKm.toDouble(),
                      0,
                      400, // Max distance set to 400km
                      (value) => filterNotifier.updateMaxDistanceInKm(value.round()),
                    ),
                    const SizedBox(height: 32),
                    _buildRangeSlider(
                      '나이',
                      RangeValues(filterState.filter.minAge.toDouble(), filterState.filter.maxAge.toDouble()),
                      19,
                      50,
                      (values) => filterNotifier.updateMinAge(values.start.round()),
                      (values) => filterNotifier.updateMaxAge(values.end.round()),
                    ),
                    const SizedBox(height: 32),
                    _buildRangeSlider(
                      '키',
                      RangeValues((filterState.filter.minHeight ?? 140).toDouble(), (filterState.filter.maxHeight ?? 200).toDouble()),
                      140,
                      200,
                      (values) => filterNotifier.updateMinHeight(values.start.round()),
                      (values) => filterNotifier.updateMaxHeight(values.end.round()),
                    ),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '흡연',
                      ['상관 없음', ...SmokingStatus.values.map((e) => e.name).toList()],
                      filterState.filter.smokingStatus?.name,
                      // (selectedName) => filterNotifier.updateSmokingStatus(
                      //   selectedName != null ? SmokingStatus.values.byName(selectedName) : null,
                      // ),
                            (selectedName) {
                          print('=== BEFORE UPDATE ===');
                          print('selectedName: $selectedName');
                          print('current filter: ${filterState.filter.smokingStatus}');

                          final newStatus = selectedName != null
                              ? SmokingStatus.values.byName(selectedName)
                              : null;
                          print('newStatus to set: $newStatus');

                          filterNotifier.updateSmokingStatus(newStatus);

                          // 다음 프레임에서 확인
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            print('=== AFTER UPDATE (next frame) ===');
                            print('updated filter: ${filterState.filter.smokingStatus}');
                          });
                        }
                    ),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '음주',
                      ['상관 없음', ...DrinkingStatus.values.map((e) => e.name).toList()],
                      filterState.filter.drinkingStatus?.name,
                      (selectedName) => filterNotifier.updateDrinkingStatus(
                        selectedName != null ? DrinkingStatus.values.byName(selectedName) : null,
                      ),
                    ),
                    // TODO: Add UI for currentUserLatitude and currentUserLongitude if needed
                  ],
                ),
              ),
            ),
            _buildSearchButton(context, filterState.filter, filterNotifier),
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
  Widget _buildHeader(BuildContext context, DatingFilterNotifier filterNotifier) {
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
                onPressed: () => filterNotifier.clearFilter(), // Changed to clearFilter
                child: const Text('초기화', style: TextStyle(color: Colors.pinkAccent, fontSize: 16)),
              ),
            ],
          ),
          const Text('필터', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 지역 선택 버튼 (Removed as per user request)
  // Widget _buildLocationPicker(String selectedRegion, DatingFilterNotifier filterNotifier) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text('지역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  //       const SizedBox(height: 8),
  //       InkWell(
  //         onTap: () {
  //           // TODO: 지역 선택 다이얼로그 구현 및 filterNotifier.updateRegion 호출
  //           print('지역 선택 팝업 띄우기!');
  //         },
  //         borderRadius: BorderRadius.circular(12),
  //         child: Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(12),
  //             border: Border.all(color: Colors.grey.shade300),
  //           ),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(selectedRegion, style: const TextStyle(fontSize: 16)),
  //               const Icon(Icons.chevron_right, color: Colors.pinkAccent),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // 범위 슬라이더 (나이)
  Widget _buildRangeSlider(String title, RangeValues values, double min, double max, ValueChanged<RangeValues> onMinChanged, ValueChanged<RangeValues> onMaxChanged) {
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
          onChanged: (newValues) {
            onMinChanged(newValues);
            onMaxChanged(newValues);
          },
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
  Widget _buildChoiceChipSection(String title, List<String> choices, String? groupValue, ValueChanged<String?> onSelected) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12.0,
          children: List<Widget>.generate(choices.length, (int index) {
            final choice = choices[index];
            final isNoPreference = choice == '상관 없음';
            return ChoiceChip(
              label: Text(choice),
              selected: isNoPreference ? groupValue == null : groupValue == choice,
              onSelected: (bool selectedFromChip) {

                if (isNoPreference) { // '상관 없음' 칩을 탭한 경우
                  onSelected(null); // 무조건 null로 설정 (선택/해제 모두 '상관 없음' 상태로)
                } else { // 특정 선호도 칩을 탭한 경우
                  if (selectedFromChip) { // 칩이 이제 선택된 상태라면
                    onSelected(choice); // 해당 칩의 값으로 설정
                  } else { // 칩이 이제 선택 해제된 상태라면
                    onSelected(null); // '상관 없음' 상태(null)로 돌아감
                  }
                }
              },
              selectedColor: Colors.pink.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: (isNoPreference ? groupValue == null : groupValue == choice) ? Colors.pinkAccent : Colors.grey.shade300,
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
    DatingFilter currentFilter,
    DatingFilterNotifier filterNotifier,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () async {
          await filterNotifier.saveFilter();
          if (context.mounted) {
            Navigator.of(context).pop(currentFilter); // Pop with the current filter
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
