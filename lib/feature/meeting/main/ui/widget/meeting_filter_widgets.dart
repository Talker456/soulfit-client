import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../domain/entity/meeting_filter_params.dart';
import '../notifier/meeting_list_notifier.dart';
import '../provider/meeting_list_providers.dart';
import '../state/meeting_list_state.dart';
import 'filter_modals/region_filter_modal.dart';
import 'filter_modals/date_range_filter_modal.dart';
import 'filter_modals/price_range_filter_modal.dart';
import 'filter_modals/rating_filter_modal.dart';
import 'filter_modals/participants_filter_modal.dart';

class MeetingFilterBar extends ConsumerWidget {
  final String listType;

  const MeetingFilterBar({super.key, required this.listType});

  StateNotifierProvider<MeetingListNotifier, MeetingListState> _getProvider(String listType) {
    switch (listType) {
      case 'aiRecommended':
        return aiRecommendedMeetingsProvider;
      case 'popular':
        return popularMeetingsProvider;
      case 'recentlyCreated':
        return recentlyCreatedMeetingsProvider;
      case 'userRecentJoined':
        return userRecentJoinedMeetingsProvider;
      default: // 카테고리
        return meetingsByCategoryProvider(listType);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFilters = (ref.watch(_getProvider(listType)) as MeetingListLoaded).activeFilters;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          // 지역 필터
          ElevatedButton(
            onPressed: () async {
              final selectedRegion = await showModalBottomSheet<String>(
                context: context,
                builder: (BuildContext modalContext) {
                  return RegionFilterModal(initialRegion: currentFilters?.region);
                },
              );
              if (selectedRegion != null) {
                ref.read(_getProvider(listType).notifier).applyFilters(
                      currentFilters?.copyWith(region: selectedRegion) ??
                          MeetingFilterParams(region: selectedRegion),
                    );
              }
            },
            child: Text(currentFilters?.region != null ? '지역: ${currentFilters!.region}' : '지역'),
          ),
          const SizedBox(width: 8),

          // 일정 필터
          ElevatedButton(
            onPressed: () async {
              final selectedDates = await showModalBottomSheet<Map<String, DateTime?>>(
                context: context,
                builder: (BuildContext modalContext) {
                  return DateRangeFilterModal(
                    initialStartDate: currentFilters?.startDate,
                    initialEndDate: currentFilters?.endDate,
                  );
                },
              );
              if (selectedDates != null) {
                ref.read(_getProvider(listType).notifier).applyFilters(
                      currentFilters?.copyWith(
                            startDate: selectedDates['startDate'],
                            endDate: selectedDates['endDate'],
                          ) ??
                          MeetingFilterParams(
                            startDate: selectedDates['startDate'],
                            endDate: selectedDates['endDate'],
                          ),
                    );
              }
            },
            child: Text(
              currentFilters?.startDate != null || currentFilters?.endDate != null
                  ? '일정: ${currentFilters?.startDate != null ? DateFormat('MM/dd').format(currentFilters!.startDate!) : ''} ~ ${currentFilters?.endDate != null ? DateFormat('MM/dd').format(currentFilters!.endDate!) : ''}'
                  : '일정',
            ),
          ),
          const SizedBox(width: 8),

          // 가격 필터
          ElevatedButton(
            onPressed: () async {
              final selectedPrices = await showModalBottomSheet<Map<String, double?>>(
                context: context,
                builder: (BuildContext modalContext) {
                  return PriceRangeFilterModal(
                    initialMinPrice: currentFilters?.minPrice,
                    initialMaxPrice: currentFilters?.maxPrice,
                  );
                },
              );
              if (selectedPrices != null) {
                ref.read(_getProvider(listType).notifier).applyFilters(
                      currentFilters?.copyWith(
                            minPrice: selectedPrices['minPrice'],
                            maxPrice: selectedPrices['maxPrice'],
                          ) ??
                          MeetingFilterParams(
                            minPrice: selectedPrices['minPrice'],
                            maxPrice: selectedPrices['maxPrice'],
                          ),
                    );
              }
            },
            child: Text(
              currentFilters?.minPrice != null || currentFilters?.maxPrice != null
                  ? '가격: ${currentFilters?.minPrice != null ? NumberFormat.compact().format(currentFilters!.minPrice!) : ''} ~ ${currentFilters?.maxPrice != null ? NumberFormat.compact().format(currentFilters!.maxPrice!) : ''}'
                  : '가격',
            ),
          ),
          const SizedBox(width: 8),

          // 평점 필터
          ElevatedButton(
            onPressed: () async {
              final selectedRating = await showModalBottomSheet<Map<String, double?>>(
                context: context,
                builder: (BuildContext modalContext) {
                  return RatingFilterModal(initialMinRating: currentFilters?.minRating);
                },
              );
              if (selectedRating != null) {
                ref.read(_getProvider(listType).notifier).applyFilters(
                      currentFilters?.copyWith(minRating: selectedRating['minRating']) ??
                          MeetingFilterParams(minRating: selectedRating['minRating']),
                    );
              }
            },
            child: Text(currentFilters?.minRating != null ? '평점: ${currentFilters!.minRating!.toStringAsFixed(1)}' : '평점'),
          ),
          const SizedBox(width: 8),

          // 인원수 필터
          ElevatedButton(
            onPressed: () async {
              final selectedParticipants = await showModalBottomSheet<Map<String, int?>>(
                context: context,
                builder: (BuildContext modalContext) {
                  return ParticipantsFilterModal(
                    initialMinParticipants: currentFilters?.minParticipants,
                    initialMaxParticipants: currentFilters?.maxParticipants,
                  );
                },
              );
              if (selectedParticipants != null) {
                ref.read(_getProvider(listType).notifier).applyFilters(
                      currentFilters?.copyWith(
                            minParticipants: selectedParticipants['minParticipants'],
                            maxParticipants: selectedParticipants['maxParticipants'],
                          ) ??
                          MeetingFilterParams(
                            minParticipants: selectedParticipants['minParticipants'],
                            maxParticipants: selectedParticipants['maxParticipants'],
                          ),
                    );
              }
            },
            child: Text(
              currentFilters?.minParticipants != null || currentFilters?.maxParticipants != null
                  ? '인원: ${currentFilters?.minParticipants != null ? currentFilters!.minParticipants : ''} ~ ${currentFilters?.maxParticipants != null ? currentFilters!.maxParticipants : ''}'
                  : '인원수',
            ),
          ),
          const SizedBox(width: 8),

          // 필터 초기화
          ElevatedButton(
            onPressed: () {
              ref.read(_getProvider(listType).notifier).applyFilters(
                const MeetingFilterParams(),
              );
            },
            child: const Text('필터 초기화'),
          ),
        ],
      ),
    );
  }
}
