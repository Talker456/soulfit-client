import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/meeting_post_providers.dart';
import '../widget/header_image_carousel.dart';
import '../widget/section_keywords.dart';
import '../widget/section_schedule_timeline.dart';
import '../widget/section_places.dart';
import '../widget/section_participant_stats.dart';
import '../widget/section_reviews.dart';
import '../widget/section_supplies.dart';

class MeetingPostScreen extends ConsumerStatefulWidget {
  final String postId;
  const MeetingPostScreen({super.key, required this.postId});

  @override
  ConsumerState<MeetingPostScreen> createState() => _MeetingPostScreenState();
}

class _MeetingPostScreenState extends ConsumerState<MeetingPostScreen>
    with TickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 6, vsync: this);
    // 데이터 로드
    Future.microtask(
      () => ref.read(meetingPostProvider.notifier).fetch(widget.postId),
    );
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final st = ref.watch(meetingPostProvider);

    // 1) 로딩
    if (st.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 2) 에러
    if (st.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('모임')),
        body: Center(child: Text('에러: ${st.error}')),
      );
    }

    // 3) 데이터 없음(방어)
    if (st.data == null) {
      return const Scaffold(body: Center(child: Text('게시물을 찾을 수 없습니다.')));
    }

    // 4) 성공
    final d = st.data!;

    return Scaffold(
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: SizedBox(
          height: 52,
          child: FilledButton(
            onPressed: () {},
            child: Text('참여하기 ${_money(d.pricePerPerson)}'),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 6,
        child: NestedScrollView(
          headerSliverBuilder:
              (_, __) => [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 240,
                  title: Text(
                    d.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: HeaderImageCarousel(images: d.images),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  ],
                  bottom: TabBar(
                    isScrollable: true,
                    controller: _tab,
                    tabs: const [
                      Tab(text: '상세정보'),
                      Tab(text: '스케줄'),
                      Tab(text: '참가자'),
                      Tab(text: '장소'),
                      Tab(text: '리뷰'),
                      Tab(text: '준비물'),
                    ],
                  ),
                ),
              ],
          body: TabBarView(
            controller: _tab,
            children: [
              // 상세정보
              _SectionPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '모임 설명',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 6),
                    Text(d.description),
                    const SizedBox(height: 12),
                    SectionKeywords(keywords: d.keywords),
                  ],
                ),
              ),
              // 스케줄
              _SectionPadding(
                child: SectionScheduleTimeline(schedules: d.schedules),
              ),
              // 참가자
              _SectionPadding(child: SectionParticipantStats(stats: d.stats)),
              // 장소
              _SectionPadding(
                child: SectionPlaces(
                  meetAddress: d.meetPlaceAddress,
                  venueAddress: d.venuePlaceAddress,
                ),
              ),
              // 리뷰
              _SectionPadding(
                child: SectionReviews(
                  count: d.reviewCount,
                  avg: d.reviewAvg,
                  summary: d.reviewSummary,
                  items: d.reviews,
                ),
              ),
              // 준비물
              _SectionPadding(child: SectionSupplies(items: d.supplies)),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionPadding extends StatelessWidget {
  final Widget child;
  const _SectionPadding({required this.child});
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
    child: child,
  );
}

String _money(int v) {
  final s = v.toString();
  final b = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final idx = s.length - i;
    b.write(s[i]);
    if (idx > 1 && idx % 3 == 1) b.write(',');
  }
  return '${b.toString()}₩';
}
