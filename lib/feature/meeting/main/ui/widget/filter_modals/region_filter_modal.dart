import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/meeting/main/domain/entity/region.dart';

class RegionFilterModal extends ConsumerStatefulWidget {
  final Map<String, String?>? initialRegion;

  const RegionFilterModal({super.key, this.initialRegion});

  @override
  ConsumerState<RegionFilterModal> createState() => _RegionFilterModalState();
}

class _RegionFilterModalState extends ConsumerState<RegionFilterModal> {
  Map<String, String?> _selectedRegion = {'province': null, 'district': null};
  Region? _selectedProvince;

  static final List<Region> allRegions = [
    Region(name: '서울', subRegions: [
      Region(name: '강남구'),
      Region(name: '서초구'),
      Region(name: '송파구'),
      Region(name: '영등포구'),
      Region(name: '마포구'),
      Region(name: '종로구'),
      Region(name: '중구'),
      Region(name: '용산구'),
      Region(name: '성동구'),
      Region(name: '광진구'),
      Region(name: '동대문구'),
      Region(name: '중랑구'),
      Region(name: '성북구'),
      Region(name: '강북구'),
      Region(name: '도봉구'),
      Region(name: '노원구'),
      Region(name: '은평구'),
      Region(name: '서대문구'),
      Region(name: '양천구'),
      Region(name: '강서구'),
      Region(name: '구로구'),
      Region(name: '금천구'),
      Region(name: '동작구'),
      Region(name: '관악구'),
      Region(name: '서초구'),
      Region(name: '강동구'),
    ]),
    Region(name: '경기', subRegions: [
      Region(name: '수원시'),
      Region(name: '성남시'),
      Region(name: '고양시'),
      Region(name: '용인시'),
      Region(name: '부천시'),
      Region(name: '안산시'),
      Region(name: '화성시'),
      Region(name: '남양주시'),
      Region(name: '안양시'),
      Region(name: '평택시'),
      Region(name: '의정부시'),
      Region(name: '파주시'),
      Region(name: '시흥시'),
      Region(name: '광명시'),
      Region(name: '김포시'),
      Region(name: '군포시'),
      Region(name: '광주시'),
      Region(name: '이천시'),
      Region(name: '오산시'),
      Region(name: '하남시'),
      Region(name: '양주시'),
      Region(name: '구리시'),
      Region(name: '안성시'),
      Region(name: '포천시'),
      Region(name: '의왕시'),
      Region(name: '여주시'),
      Region(name: '동두천시'),
      Region(name: '과천시'),
      Region(name: '가평군'),
      Region(name: '양평군'),
      Region(name: '연천군'),
    ]),
    Region(name: '부산', subRegions: [
      Region(name: '강서구'),
      Region(name: '금정구'),
      Region(name: '기장군'),
      Region(name: '남구'),
      Region(name: '동구'),
      Region(name: '동래구'),
      Region(name: '진구'),
      Region(name: '북구'),
      Region(name: '사상구'),
      Region(name: '사하구'),
      Region(name: '서구'),
      Region(name: '수영구'),
      Region(name: '연제구'),
      Region(name: '영도구'),
      Region(name: '중구'),
      Region(name: '해운대구'),
    ]),
    Region(name: '대구', subRegions: [
      Region(name: '남구'),
      Region(name: '달서구'),
      Region(name: '달성군'),
      Region(name: '동구'),
      Region(name: '북구'),
      Region(name: '서구'),
      Region(name: '수성구'),
      Region(name: '중구'),
      Region(name: '군위군'),
    ]),
    Region(name: '인천', subRegions: [
      Region(name: '강화군'),
      Region(name: '계양구'),
      Region(name: '미추홀구'),
      Region(name: '남동구'),
      Region(name: '동구'),
      Region(name: '부평구'),
      Region(name: '서구'),
      Region(name: '연수구'),
      Region(name: '옹진군'),
      Region(name: '중구'),
    ]),
    Region(name: '광주', subRegions: [
      Region(name: '광산구'),
      Region(name: '남구'),
      Region(name: '동구'),
      Region(name: '북구'),
      Region(name: '서구'),
    ]),
    Region(name: '대전', subRegions: [
      Region(name: '대덕구'),
      Region(name: '동구'),
      Region(name: '서구'),
      Region(name: '유성구'),
      Region(name: '중구'),
    ]),
    Region(name: '울산', subRegions: [
      Region(name: '남구'),
      Region(name: '동구'),
      Region(name: '북구'),
      Region(name: '울주군'),
      Region(name: '중구'),
    ]),
    Region(name: '세종', subRegions: []),
    Region(name: '강원', subRegions: [
      Region(name: '강릉시'),
      Region(name: '동해시'),
      Region(name: '삼척시'),
      Region(name: '속초시'),
      Region(name: '원주시'),
      Region(name: '춘천시'),
      Region(name: '태백시'),
      Region(name: '고성군'),
      Region(name: '양구군'),
      Region(name: '양양군'),
      Region(name: '영월군'),
      Region(name: '인제군'),
      Region(name: '정선군'),
      Region(name: '철원군'),
      Region(name: '평창군'),
      Region(name: '홍천군'),
      Region(name: '화천군'),
      Region(name: '횡성군'),
    ]),
    Region(name: '충북', subRegions: [
      Region(name: '제천시'),
      Region(name: '청주시'),
      Region(name: '충주시'),
      Region(name: '괴산군'),
      Region(name: '단양군'),
      Region(name: '보은군'),
      Region(name: '영동군'),
      Region(name: '옥천군'),
      Region(name: '음성군'),
      Region(name: '증평군'),
      Region(name: '진천군'),
      Region(name: '청원군'),
    ]),
    Region(name: '충남', subRegions: [
      Region(name: '계룡시'),
      Region(name: '공주시'),
      Region(name: '논산시'),
      Region(name: '당진시'),
      Region(name: '보령시'),
      Region(name: '서산시'),
      Region(name: '아산시'),
      Region(name: '천안시'),
      Region(name: '금산군'),
      Region(name: '부여군'),
      Region(name: '서천군'),
      Region(name: '예산군'),
      Region(name: '청양군'),
      Region(name: '태안군'),
      Region(name: '홍성군'),
    ]),
    Region(name: '전북', subRegions: [
      Region(name: '군산시'),
      Region(name: '김제시'),
      Region(name: '남원시'),
      Region(name: '익산시'),
      Region(name: '전주시'),
      Region(name: '정읍시'),
      Region(name: '고창군'),
      Region(name: '무주군'),
      Region(name: '부안군'),
      Region(name: '순창군'),
      Region(name: '완주군'),
      Region(name: '임실군'),
      Region(name: '장수군'),
      Region(name: '진안군'),
    ]),
    Region(name: '전남', subRegions: [
      Region(name: '광양시'),
      Region(name: '나주시'),
      Region(name: '목포시'),
      Region(name: '순천시'),
      Region(name: '여수시'),
      Region(name: '강진군'),
      Region(name: '고흥군'),
      Region(name: '곡성군'),
      Region(name: '구례군'),
      Region(name: '담양군'),
      Region(name: '무안군'),
      Region(name: '보성군'),
      Region(name: '신안군'),
      Region(name: '영광군'),
      Region(name: '영암군'),
      Region(name: '완도군'),
      Region(name: '장성군'),
      Region(name: '장흥군'),
      Region(name: '진도군'),
      Region(name: '함평군'),
      Region(name: '해남군'),
      Region(name: '화순군'),
    ]),
    Region(name: '경북', subRegions: [
      Region(name: '경산시'),
      Region(name: '경주시'),
      Region(name: '구미시'),
      Region(name: '김천시'),
      Region(name: '문경시'),
      Region(name: '상주시'),
      Region(name: '안동시'),
      Region(name: '영주시'),
      Region(name: '영천시'),
      Region(name: '포항시'),
      Region(name: '고령군'),
      Region(name: '봉화군'),
      Region(name: '성주군'),
      Region(name: '영덕군'),
      Region(name: '영양군'),
      Region(name: '예천군'),
      Region(name: '울릉군'),
      Region(name: '울진군'),
      Region(name: '의성군'),
      Region(name: '청도군'),
      Region(name: '청송군'),
      Region(name: '칠곡군'),
    ]),
    Region(name: '경남', subRegions: [
      Region(name: '거제시'),
      Region(name: '김해시'),
      Region(name: '밀양시'),
      Region(name: '사천시'),
      Region(name: '양산시'),
      Region(name: '진주시'),
      Region(name: '창원시'),
      Region(name: '통영시'),
      Region(name: '거창군'),
      Region(name: '고성군'),
      Region(name: '남해군'),
      Region(name: '산청군'),
      Region(name: '의령군'),
      Region(name: '창녕군'),
      Region(name: '하동군'),
      Region(name: '함안군'),
      Region(name: '함양군'),
      Region(name: '합천군'),
    ]),
    Region(name: '제주', subRegions: [
      Region(name: '서귀포시'),
      Region(name: '제주시'),
    ]),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialRegion != null) {
      _selectedRegion = Map.from(widget.initialRegion!);
      if (_selectedRegion['province'] != null) {
        _selectedProvince = allRegions.firstWhere(
          (region) => region.name == _selectedRegion['province'],
          orElse: () => allRegions.first, // Fallback, though ideally initialRegion should be valid
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text(
            '지역 선택',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Province selection
          Wrap(
            spacing: 8.0,
            children: allRegions.map((region) {
              final isSelected = _selectedRegion['province'] == region.name;
              return _buildChip(
                context,
                region.name,
                isSelected,
                () {
                  setState(() {
                    if (isSelected) {
                      _selectedRegion['province'] = null;
                      _selectedRegion['district'] = null;
                      _selectedProvince = null;
                    } else {
                      _selectedRegion['province'] = region.name;
                      _selectedRegion['district'] = null; // Reset district on new province selection
                      _selectedProvince = region;
                    }
                  });
                },
              );
            }).toList(),
          ),
          if (_selectedProvince != null && _selectedProvince!.subRegions != null && _selectedProvince!.subRegions!.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text(
              '세부 지역 선택',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // District selection
            Wrap(
              spacing: 8.0,
              children: _selectedProvince!.subRegions!.map((district) {
                final isSelected = _selectedRegion['district'] == district.name;
                return _buildChip(
                  context,
                  district.name,
                  isSelected,
                  () {
                    setState(() {
                      _selectedRegion['district'] = isSelected ? null : district.name;
                    });
                  },
                );
              }).toList(),
            ),
          ],
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
    ));
  }

  Widget _buildChip(BuildContext context, String label, bool isSelected, VoidCallback onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        onSelected(); // Call the provided onSelected callback
      },
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? Theme.of(context).primaryColor : Colors.black,
      ),
    );
  }
}