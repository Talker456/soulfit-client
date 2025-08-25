import 'package:flutter/material.dart';

// --- 1. 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---
// 각 모임의 정보를 담는 구조입니다.
class PopularGroup {
  final String title;
  final String location;
  final int price;
  final int currentParticipants;
  final int maxParticipants;
  final String imageUrl;

  PopularGroup({
    required this.title,
    required this.location,
    required this.price,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.imageUrl,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
// 백엔드 API가 완성되기 전까지 이 가짜 데이터를 사용해서 UI를 만듭니다.
final List<PopularGroup> dummyPopularGroups = [
  PopularGroup(
    title: '거북 베이킹',
    location: '수원',
    price: 30000,
    currentParticipants: 6,
    maxParticipants: 8,
    imageUrl: 'https://placehold.co/100x100/A2E9F0/333333?text=🐢',
  ),
  PopularGroup(
    title: '거북 베이킹',
    location: '수원',
    price: 30000,
    currentParticipants: 6,
    maxParticipants: 8,
    imageUrl: 'https://placehold.co/100x100/A2E9F0/333333?text=🐢',
  ),
  PopularGroup(
    title: '거북 배드민턴',
    location: '강남',
    price: 3000,
    currentParticipants: 24,
    maxParticipants: 30,
    imageUrl: 'https://placehold.co/100x100/FFDDC1/333333?text=🏸',
  ),
  PopularGroup(
    title: '거북 봉사단',
    location: '부산',
    price: 5000,
    currentParticipants: 13,
    maxParticipants: 20,
    imageUrl: 'https://placehold.co/100x100/D4F0F0/333333?text=❤️',
  ),
  PopularGroup(
    title: '거북 스터디',
    location: '안성',
    price: 5000,
    currentParticipants: 7,
    maxParticipants: 10,
    imageUrl: 'https://placehold.co/100x100/FFFACD/333333?text=📚',
  ),
  PopularGroup(
    title: '거북 클라이밍',
    location: '수원',
    price: 20000,
    currentParticipants: 17,
    maxParticipants: 35,
    imageUrl: 'https://placehold.co/100x100/E6E6FA/333333?text=🧗',
  ),
];

// --- 3. 화면을 그리는 메인 위젯 ---
class PopularGroupsScreen extends StatefulWidget {
  final List<PopularGroup> groups;
  const PopularGroupsScreen({super.key, required this.groups});

  @override
  State<PopularGroupsScreen> createState() => _PopularGroupsScreenState();
}

class _PopularGroupsScreenState extends State<PopularGroupsScreen> {
  String _selectedRegion = '지역';
  String _selectedSubRegion = '';
  String _selectedDate = '일정';
  String _selectedPrice = '전체';
  String _selectedRating = '전체';
  String _selectedPeople = '전체';

  // 필터 버튼들을 가로로 나열하는 위젯
  Widget _buildFilterBar(BuildContext context) {
    // 한 화면에 3~4개만 보이도록 버튼 폭을 넓힘
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        children: [
          _buildFilterChip(
            icon: Icons.location_on,
            label: '지역',
            subLabel: _selectedSubRegion.isNotEmpty ? _selectedSubRegion : (_selectedRegion != '지역' ? _selectedRegion : null),
            onTap: () => _showRegionBottomSheet(context),
            minWidth: 80,
          ),
          _buildFilterChip(
            icon: Icons.calendar_today,
            label: '일정',
            subLabel: _selectedDate != '일정' ? _selectedDate : null,
            onTap: () => _showCalendarBottomSheet(context),
            minWidth: 80,
          ),
          _buildFilterChip(
            icon: Icons.paid,
            label: '가격',
            subLabel: _selectedPrice != '전체' ? _selectedPrice : null,
            onTap: () => _showPriceBottomSheet(context),
            minWidth: 80,
          ),
          _buildFilterChip(
            icon: Icons.star_border,
            label: '평점',
            subLabel: _selectedRating != '전체' ? _selectedRating : null,
            onTap: () => _showRatingBottomSheet(context),
            minWidth: 80,
          ),
          _buildFilterChip(
            icon: Icons.groups,
            label: '인원',
            subLabel: _selectedPeople != '전체' ? _selectedPeople : null,
            onTap: () => _showPeopleBottomSheet(context),
            minWidth: 80,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildSoulfitAppBar(context),
      body: Column(
        children: [
          _buildPopularGroupAppBar(context),
          _buildFilterBar(context),
          const Divider(height: 1, color: Color(0xFFE4FFDF)),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: widget.groups.length,
              itemBuilder: (context, index) {
                final group = widget.groups[index];
                return _buildGroupListItem(group);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // 기존 인기모임 AppBar(뒤로가기+타이틀)를 위젯으로 분리
  Widget _buildPopularGroupAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: Text(
                  '인기 모임',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48), // 오른쪽 여백(뒤로가기와 균형)
            ],
          ),
        ),
      ),
    );
  }
  // mainscreen.dart에서 가져온 soulfit AppBar
  PreferredSizeWidget _buildSoulfitAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      title: const Text(
        'soulfit',
        style: TextStyle(
          color: Color(0xBC37A23C),
          fontSize: 28,
          fontFamily: 'Arima Madurai',
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.send_outlined, color: Colors.black54),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black54),
          onPressed: () {},
        ),
      ],
    );
  }

  // mainscreen.dart에서 가져온 하단바
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: const Color(0xBC37A23C),
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: 'Saved'),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Alerts'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      onTap: (index) {
        // TODO: 원하는 네비게이션 동작 구현
      },
    );
  }
  // 가격 바텀시트
  void _showPriceBottomSheet(BuildContext context) {
    final List<String> priceOptions = [
      '전체', '2만원 미만', '2~4만원', '4~6만원', '6~8만원'
    ];
    _showRadioBottomSheet(
      context: context,
      title: '',
      options: priceOptions,
      selected: _selectedPrice,
      onSelected: (val) => setState(() => _selectedPrice = val),
    );
  }

  // 평점 바텀시트
  void _showRatingBottomSheet(BuildContext context) {
    final List<String> ratingOptions = [
      '전체', '4.0~4.5점', '3.5~4.5점', '3.0~4.5점', '0점'
    ];
    _showRadioBottomSheet(
      context: context,
      title: '',
      options: ratingOptions,
      selected: _selectedRating,
      onSelected: (val) => setState(() => _selectedRating = val),
      italicIndices: [1,2,3,4],
    );
  }

  // 인원 바텀시트
  void _showPeopleBottomSheet(BuildContext context) {
    final List<String> peopleOptions = [
      '전체', '10명 이상', '20명 이상', '30명 이상', '40명 이상'
    ];
    _showRadioBottomSheet(
      context: context,
      title: '',
      options: peopleOptions,
      selected: _selectedPeople,
      onSelected: (val) => setState(() => _selectedPeople = val),
      italicIndices: [1,2,3,4],
    );
  }

  // 공통 라디오 바텀시트
  void _showRadioBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
    List<int>? italicIndices,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 420,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                border: Border.fromBorderSide(BorderSide(color: Colors.black12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 32),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(options.length, (i) {
                    final isSelected = selected == options[i];
                    return GestureDetector(
                      onTap: () {
                        onSelected(options[i]);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected ? const Color(0xFFF2F2F2) : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 14,
                                        height: 14,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            italicIndices != null && italicIndices.contains(i)
                                ? Text(
                                    options[i],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                : Text(
                                    options[i],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 재사용 가능한 필터 버튼 위젯
  Widget _buildFilterChip({
    required IconData icon,
    required String label,
    String? subLabel,
    VoidCallback? onTap,
    double minWidth = 80,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            constraints: BoxConstraints(minWidth: minWidth),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: Colors.black54),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    subLabel ?? label,
                    style: TextStyle(
                      fontSize: 14,
                      color: subLabel != null ? Colors.black87 : Colors.black54,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // 지역 바텀시트 (2단계 선택)
  void _showRegionBottomSheet(BuildContext context) {
    final List<String> mainRegions = ['즐겨찾기', '서울', '경기', '인천'];
    final Map<String, List<String>> subRegions = {
      '즐겨찾기': ['서울 전체'],
      '서울': ['서울 전체', '강남·서초', '용산'],
      '경기': ['수원', '성남', '고양', '용인'],
      '인천': ['인천 전체', '부평', '연수'],
    };
    String selectedMain = mainRegions.contains(_selectedRegion) ? _selectedRegion : mainRegions[0];
    String selectedSub = _selectedSubRegion;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 420,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                border: Border.fromBorderSide(BorderSide(color: Colors.black12)),
              ),
              child: Row(
                children: [
                  // 왼쪽 대분류
                  Container(
                    width: 120,
                    color: const Color(0xFFF2F2F2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.close, size: 32),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        ...mainRegions.map((region) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                              child: GestureDetector(
                                onTap: () => setState(() {
                                  selectedMain = region;
                                  selectedSub = '';
                                }),
                                child: Text(
                                  region,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: selectedMain == region ? Colors.black : Colors.black87,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  // 오른쪽 소분류
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, left: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...?subRegions[selectedMain]?.map((sub) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSub = sub;
                                    });
                                    setState(() {
                                      _selectedRegion = selectedMain;
                                      _selectedSubRegion = sub;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        selectedSub == sub ? Icons.radio_button_checked : Icons.radio_button_off,
                                        size: 24,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        sub,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 일정(캘린더) 바텀시트
  void _showCalendarBottomSheet(BuildContext context) async {
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay = _selectedDate != '일정' ? DateTime.tryParse(_selectedDate.replaceAll('.', '-')) : null;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 480,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                border: Border.fromBorderSide(BorderSide(color: Colors.black12)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, size: 32),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 32),
                        child: Text(
                          '일정',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '${focusedDay.year}년 ${focusedDay.month}월',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  // 캘린더 위젯
                  Expanded(
                    child: CalendarDatePicker(
                      initialDate: selectedDay ?? focusedDay,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      onDateChanged: (date) {
                        setState(() {
                          selectedDay = date;
                          focusedDay = date;
                        });
                        setState(() {
                          _selectedDate = '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
                        });
                        Navigator.of(context).pop();
                      },
                      currentDate: selectedDay,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 각 모임 목록 아이템을 만드는 위젯
  Widget _buildGroupListItem(PopularGroup group) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0, // 그림자 제거
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF79C72B), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // 모임 대표 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                group.imageUrl,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[200],
                    child: const Icon(Icons.error),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // 상세 정보 (제목, 가격, 인원)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[${group.location}] ${group.title}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${group.price}원 · ${group.currentParticipants}명/${group.maxParticipants}명',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PopularGroupsScreen(groups: dummyPopularGroups),
    ),
  );
}