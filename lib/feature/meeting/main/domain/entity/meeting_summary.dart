class MeetingSummary {
  final String meetingId;
  final String title;
  final String thumbnailUrl;
  final String category;
  final int currentParticipants;
  final int maxParticipants;
  final int price;
  final Map<String, String?>? region; // Added region field

  const MeetingSummary({
    required this.meetingId,
    required this.title,
    required this.thumbnailUrl,
    required this.category,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.price,
    this.region, // Added to constructor
  });
}