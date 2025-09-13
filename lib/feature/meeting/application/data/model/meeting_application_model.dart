import '../../domain/entity/meeting_application.dart';

class MeetingApplicationModel {
  final String applicantName;
  final String contact;
  final String preferredDateIso;
  final int headcount;
  final String note;
  final bool agreeTerms;

  MeetingApplicationModel({
    required this.applicantName,
    required this.contact,
    required this.preferredDateIso,
    required this.headcount,
    required this.note,
    required this.agreeTerms,
  });

  factory MeetingApplicationModel.fromEntity(MeetingApplication e) {
    return MeetingApplicationModel(
      applicantName: e.applicantName,
      contact: e.contact,
      preferredDateIso: e.preferredDate.toIso8601String(),
      headcount: e.headcount,
      note: e.note,
      agreeTerms: e.agreeTerms,
    );
  }

  Map<String, dynamic> toJson() => {
    'applicant_name': applicantName,
    'contact': contact,
    'preferred_date': preferredDateIso,
    'headcount': headcount,
    'note': note,
    'agree_terms': agreeTerms,
  };
}
