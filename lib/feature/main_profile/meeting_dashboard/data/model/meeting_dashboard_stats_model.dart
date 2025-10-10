
import '../../domain/entity/meeting_dashboard_stats.dart';

class MeetingDashboardStatsModel extends MeetingDashboardStats {
  MeetingDashboardStatsModel({
    required super.totalMeetingsAttended,
    required super.monthlyActivity,
    required super.categoryDistribution,
    required super.mostAttendedCategory,
    required super.favoriteDayOfWeek,
    required super.favoriteTimeOfDay,
    required super.averageMeetingSize,
    required super.mostFrequentRegion,
    required super.averageRatingGiven,
    required super.averageRatingReceivedAsHost,
  });

  factory MeetingDashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return MeetingDashboardStatsModel(
      totalMeetingsAttended: json['totalMeetingsAttended'] as int? ?? 0,
      monthlyActivity: Map<String, int>.from(json['monthlyActivity'] as Map? ?? {}),
      categoryDistribution: Map<String, int>.from(json['categoryDistribution'] as Map? ?? {}),
      mostAttendedCategory: json['mostAttendedCategory'] as String? ?? '',
      favoriteDayOfWeek: json['favoriteDayOfWeek'] as String? ?? '',
      favoriteTimeOfDay: json['favoriteTimeOfDay'] as String? ?? '',
      averageMeetingSize: (json['averageMeetingSize'] as num?)?.toDouble() ?? 0.0,
      mostFrequentRegion: json['mostFrequentRegion'] as String? ?? '',
      averageRatingGiven: (json['averageRatingGiven'] as num?)?.toDouble() ?? 0.0,
      averageRatingReceivedAsHost: (json['averageRatingReceivedAsHost'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'totalMeetingsAttended': totalMeetingsAttended,
    'monthlyActivity': monthlyActivity,
    'categoryDistribution': categoryDistribution,
    'mostAttendedCategory': mostAttendedCategory,
    'favoriteDayOfWeek': favoriteDayOfWeek,
    'favoriteTimeOfDay': favoriteTimeOfDay,
    'averageMeetingSize': averageMeetingSize,
    'mostFrequentRegion': mostFrequentRegion,
    'averageRatingGiven': averageRatingGiven,
    'averageRatingReceivedAsHost': averageRatingReceivedAsHost,
  };
}