import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/meeting_post_state.dart';

class MeetingPostNotifier extends StateNotifier<MeetingPostState> {
  MeetingPostNotifier() : super(const MeetingPostState(loading: true));

  Future<void> fetch(String id) async {
    state = state.copyWith(loading: true, error: null);
    try {
      // TODO: FastAPI 연동. 지금은 더미를 사용합니다.
      await Future.delayed(const Duration(milliseconds: 300));

      final dummy = MeetingPost(
        id: id,
        title: '모임 제목 | 커피테이스팅',
        hostName: '호스트A',
        images: [
          'https://picsum.photos/seed/1/1200/800',
          'https://picsum.photos/seed/2/1200/800',
          'https://picsum.photos/seed/3/1200/800',
        ],
        ddayBadge: 'D-4',
        communityButtonText: '커뮤니티 바로가기',
        description: '개설할 때 설명란에 적었던 내용',
        keywords: ['키워드1', '키워드2', '키워드3', '픽업가능'],
        schedules: [
          MPSchedule('11:00 ~ 11:30', '스케줄 1'),
          MPSchedule('11:30 ~ 12:00', '스케줄 2'),
          MPSchedule('12:00 ~ 12:30', '스케줄 3'),
          MPSchedule('12:30 ~ 13:00', '스케줄 4'),
        ],
        meetPlaceAddress: '지번/도로명 주소',
        venuePlaceAddress: '경기도 수원시 영통구 광교산로 154-42',
        stats: MPStats(
          malePercent: 52,
          femalePercent: 48,
          age: {
            '10대': (20, 10),
            '20대': (35, 45),
            '30대': (40, 30),
            '40대': (30, 20),
            '50대': (10, 10),
          },
        ),
        reviewCount: 482,
        reviewAvg: 4.6,
        reviewSummary: '이 모임은…',
        reviews: [
          MPReview('닉네임1', 5.0, '리뷰 내용'),
          MPReview('닉네임2', 4.0, '좋았어요'),
        ],
        supplies: ['준비물1', '준비물2', '준비물3', '준비물4'],
        pricePerPerson: 35000,
      );

      state = state.copyWith(loading: false, data: dummy);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
