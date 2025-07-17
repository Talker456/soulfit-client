

import 'package:soulfit_client/feature/authentication/domain/entity/change_credential_data.dart';

class ChangeCredentialRequestDto {
  final String currentPassword;
  late String accessToken;
  final String newEmail;
  final String newPassword;

  ChangeCredentialRequestDto({
    this.currentPassword = '',
    this.accessToken = '',
    this.newEmail = '',
    this.newPassword ='',
  });

  Map<String, dynamic> toJson() => {
    'currentPassword': currentPassword,
    'accessToken': accessToken,
    'newEmail': newEmail,
    'newPassword': newPassword,
  };

  factory ChangeCredentialRequestDto.fromDomain(ChangeCredentialData data) {
    return ChangeCredentialRequestDto(
      currentPassword: data.currentPassword,
      accessToken: data.accessToken,
      newEmail: data.newEmail,
      newPassword: data.newPassword,
    );
  }
}