import '../../domain/entities/user_report.dart';

class UserReportRequestDto {
  final String targetType;
  final int targetId;
  final String reason;
  final String description;

  UserReportRequestDto({
    required this.targetType,
    required this.targetId,
    required this.reason,
    required this.description,
  });

  factory UserReportRequestDto.fromEntity(UserReport report) {
    return UserReportRequestDto(
      targetType: 'USER', // Always 'USER' for this context
      targetId: report.targetId,
      reason: report.reason,
      description: report.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'targetType': targetType,
      'targetId': targetId,
      'reason': reason,
      'description': description,
    };
  }
}