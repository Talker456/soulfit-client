
class MeetingDashboardStats {
  final int totalMeetingsAttended;
  final Map<String, int> monthlyActivity;
  final Map<String, int> categoryDistribution;
  final String mostAttendedCategory;
  final String favoriteDayOfWeek;
  final String favoriteTimeOfDay;
  final double averageMeetingSize;
  final String mostFrequentRegion;
  final double averageRatingGiven;
  final double averageRatingReceivedAsHost;

  MeetingDashboardStats({
    required this.totalMeetingsAttended,
    required this.monthlyActivity,
    required this.categoryDistribution,
    required this.mostAttendedCategory,
    required this.favoriteDayOfWeek,
    required this.favoriteTimeOfDay,
    required this.averageMeetingSize,
    required this.mostFrequentRegion,
    required this.averageRatingGiven,
    required this.averageRatingReceivedAsHost,
  });
}
