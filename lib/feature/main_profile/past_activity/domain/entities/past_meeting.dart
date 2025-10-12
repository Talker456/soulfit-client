// 과거 모임 Entity
class PastMeeting {
  final int id;
  final String date;
  final String title;
  final String location;
  final int price;
  final int currentParticipants;
  final int maxParticipants;
  final String? imageUrl;
  final String status; // 'approved', 'pending', 'completed'

  PastMeeting({
    required this.id,
    required this.date,
    required this.title,
    required this.location,
    required this.price,
    required this.currentParticipants,
    required this.maxParticipants,
    this.imageUrl,
    required this.status,
  });
}
