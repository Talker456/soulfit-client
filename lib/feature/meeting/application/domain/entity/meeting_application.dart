class MeetingApplication {
  final String applicantName;
  final String contact;
  final DateTime preferredDate;
  final int headcount;
  final String note;
  final bool agreeTerms;

  const MeetingApplication({
    required this.applicantName,
    required this.contact,
    required this.preferredDate,
    required this.headcount,
    required this.note,
    required this.agreeTerms,
  });
}
