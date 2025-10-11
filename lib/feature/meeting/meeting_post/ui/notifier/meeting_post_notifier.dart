import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meeting_post_detail.dart';
import '../../domain/usecases/get_meeting_post_detail_usecase.dart';
import '../state/meeting_post_state.dart';

class MeetingPostNotifier extends StateNotifier<MeetingPostState> {
  final GetMeetingPostDetailUseCase getMeetingPostDetailUseCase;

  MeetingPostNotifier(this.getMeetingPostDetailUseCase)
      : super(const MeetingPostState(loading: true));

  Future<void> fetch(String id) async {
    state = state.copyWith(loading: true, error: null);
    try {
      // UseCase를 통한 모임 상세 정보 조회
      final entity = await getMeetingPostDetailUseCase.execute(id);

      // Entity를 UI State로 변환
      final meetingPost = _entityToState(entity);

      state = state.copyWith(loading: false, data: meetingPost);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  /// Entity를 UI State로 변환
  MeetingPost _entityToState(MeetingPostDetail entity) {
    return MeetingPost(
      id: entity.id,
      title: entity.title,
      hostName: entity.hostName,
      images: entity.imageUrls,
      ddayBadge: entity.ddayBadge,
      communityButtonText: entity.communityButtonText,
      description: entity.description,
      keywords: entity.keywords,
      schedules: entity.schedules
          .map((s) => MPSchedule(s.timeRange, s.title))
          .toList(),
      meetPlaceAddress: entity.meetPlaceAddress,
      venuePlaceAddress: entity.venuePlaceAddress,
      stats: MPStats(
        malePercent: entity.participantStats.malePercent,
        femalePercent: entity.participantStats.femalePercent,
        age: entity.participantStats.ageGroups.map(
          (key, value) => MapEntry(key, (value.maleCount, value.femaleCount)),
        ),
      ),
      reviewCount: entity.reviewCount,
      reviewAvg: entity.reviewAvg,
      reviewSummary: entity.reviewSummary,
      reviews: entity.reviews
          .map((r) => MPReview(r.author, r.rating, r.content))
          .toList(),
      supplies: entity.supplies,
      pricePerPerson: entity.pricePerPerson,
    );
  }
}
