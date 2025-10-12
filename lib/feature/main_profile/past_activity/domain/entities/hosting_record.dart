// 호스팅 기록 Entity
class HostingRecord {
  final int id;
  final String title;
  final String location;
  final int participants;
  final int revenue;
  final String? imageUrl;
  final DateTime date;

  HostingRecord({
    required this.id,
    required this.title,
    required this.location,
    required this.participants,
    required this.revenue,
    this.imageUrl,
    required this.date,
  });
}
