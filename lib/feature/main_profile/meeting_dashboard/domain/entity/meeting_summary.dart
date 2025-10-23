
class MeetingSummary {
  final int id;
  final String title;
  final String category;
  final String city;
  final int fee;
  final int maxParticipants;
  final int currentParticipants;
  final String status;

  MeetingSummary({
    required this.id,
    required this.title,
    required this.category,
    required this.city,
    required this.fee,
    required this.maxParticipants,
    required this.currentParticipants,
    required this.status,
  });
}
