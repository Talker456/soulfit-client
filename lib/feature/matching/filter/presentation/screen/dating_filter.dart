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
                    _buildLocationPicker(context, filterState.filter.region, filterNotifier),
                    const SizedBox(height: 32),
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
                      ['상관 없음', ...SmokingStatus.values.map((e) => e.displayName).toList()],
                      filterState.filter.smokingStatus?.displayName,
                      (selectedDisplayName) {
                        SmokingStatus? newStatus;
                        if (selectedDisplayName != null) {
                          newStatus = SmokingStatus.values.firstWhere((e) => e.displayName == selectedDisplayName);
                        }
                        filterNotifier.updateSmokingStatus(newStatus);
                      },
                    ),
                    const SizedBox(height: 32),
                    _buildChoiceChipSection(
                      '음주',
                      ['상관 없음', ...DrinkingStatus.values.map((e) => e.displayName).toList()],
                      filterState.filter.drinkingStatus?.displayName,
                      (selectedDisplayName) {
                        DrinkingStatus? newStatus;
                        if (selectedDisplayName != null) {
                          newStatus = DrinkingStatus.values.firstWhere((e) => e.displayName == selectedDisplayName);
                        }
                        filterNotifier.updateDrinkingStatus(newStatus);
                      },
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

  // 지역 선택 버튼
  Widget _buildLocationPicker(BuildContext context, String selectedRegion, DatingFilterNotifier filterNotifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('지역', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            const Map<String, List<String>> regionData = {
              '서울': ['전체', '강남구', '강동구', '강북구', '강서구', '관악구', '광진구', '구로구', '금천구', '노원구', '도봉구', '동대문구', '동작구', '마포구', '서대문구', '서초구', '성동구', '성북구', '송파구', '양천구', '영등포구', '용산구', '은평구', '종로구', '중구', '중랑구'],
              '경기': ['전체', '수원시', '성남시', '의정부시', '안양시', '부천시', '광명시', '평택시', '동두천시', '안산시', '고양시', '과천시', '구리시', '남양주시', '오산시', '시흥시', '군포시', '의왕시', '하남시', '용인시', '파주시', '이천시', '안성시', '김포시', '화성시', '광주시', '양주시', '포천시', '여주시', '연천군', '가평군', '양평군'],
              '인천': ['전체', '계양구', '미추홀구', '남동구', '동구', '부평구', '서구', '연수구', '중구', '강화군', '옹진군'],
              '강원': ['전체', '춘천시', '원주시', '강릉시', '동해시', '태백시', '속초시', '삼척시', '홍천군', '횡성군', '영월군', '평창군', '정선군', '철원군', '화천군', '양구군', '인제군', '고성군', '양양군'],
              '충북': ['전체', '청주시', '충주시', '제천시', '보은군', '옥천군', '영동군', '증평군', '진천군', '괴산군', '음성군', '단양군'],
              '충남': ['전체', '천안시', '공주시', '보령시', '아산시', '서산시', '논산시', '계룡시', '당진시', '금산군', '부여군', '서천군', '청양군', '홍성군', '예산군', '태안군'],
              '대전': ['전체', '대덕구', '동구', '서구', '유성구', '중구'],
              '경북': ['전체', '포항시', '경주시', '김천시', '안동시', '구미시', '영주시', '영천시', '상주시', '문경시', '경산시', '군위군', '의성군', '청송군', '영양군', '영덕군', '청도군', '고령군', '성주군', '칠곡군', '예천군', '봉화군', '울진군', '울릉군'],
              '경남': ['전체', '창원시', '진주시', '통영시', '사천시', '김해시', '밀양시', '거제시', '양산시', '의령군', '함안군', '창녕군', '고성군', '남해군', '하동군', '산청군', '함양군', '거창군', '합천군'],
              '대구': ['전체', '남구', '달서구', '동구', '북구', '서구', '수성구', '중구', '달성군'],
              '울산': ['전체', '남구', '동구', '북구', '중구', '울주군'],
              '부산': ['전체', '강서구', '금정구', '남구', '동구', '동래구', '부산진구', '북구', '사상구', '사하구', '서구', '수영구', '연제구', '영도구', '중구', '해운대구', '기장군'],
              '전북': ['전체', '전주시', '군산시', '익산시', '정읍시', '남원시', '김제시', '완주군', '진안군', '무주군', '장수군', '임실군', '순창군', '고창군', '부안군'],
              '전남': ['전체', '목포시', '여수시', '순천시', '나주시', '광양시', '담양군', '곡성군', '구례군', '고흥군', '보성군', '화순군', '장흥군', '강진군', '해남군', '영암군', '무안군', '함평군', '영광군', '장성군', '완도군', '진도군', '신안군'],
              '광주': ['전체', '광산구', '남구', '동구', '북구', '서구'],
              '제주': ['전체', '제주시', '서귀포시'],
            };

            final result = await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                String? selectedMainRegion;

                return StatefulBuilder(
                  builder: (context, setState) {
                    if (selectedMainRegion == null) {
                      // 1단계: 시/도 선택
                      final mainRegions = ['상관 없음', ...regionData.keys];
                      return SimpleDialog(
                        title: const Text('지역 선택'),
                        children: mainRegions.map((mainRegion) {
                          return SimpleDialogOption(
                            onPressed: () {
                              if (mainRegion == '상관 없음') {
                                Navigator.pop(context, '');
                              } else {
                                setState(() {
                                  selectedMainRegion = mainRegion;
                                });
                              }
                            },
                            child: Text(mainRegion),
                          );
                        }).toList(),
                      );
                    } else {
                      // 2단계: 시/군/구 선택
                      final subRegions = regionData[selectedMainRegion]!;
                      return SimpleDialog(
                        title: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () {
                                setState(() {
                                  selectedMainRegion = null;
                                });
                              },
                            ),
                            Text(selectedMainRegion!),
                          ],
                        ),
                        children: subRegions.map((subRegion) {
                          return SimpleDialogOption(
                            onPressed: () {
                              if (subRegion == '전체') {
                                Navigator.pop(context, selectedMainRegion);
                              } else {
                                Navigator.pop(context, '$selectedMainRegion $subRegion');
                              }
                            },
                            child: Text(subRegion),
                          );
                        }).toList(),
                      );
                    }
                  },
                );
              },
            );

            if (result != null) {
              filterNotifier.updateRegion(result);
            }
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
                Text(selectedRegion.isEmpty ? '상관 없음' : selectedRegion, style: const TextStyle(fontSize: 16)),
                const Icon(Icons.chevron_right, color: Colors.pinkAccent),
              ],
            ),
          ),
        ),
      ],
    );
  }

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
