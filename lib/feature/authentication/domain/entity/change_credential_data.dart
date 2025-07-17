import 'package:flutter/foundation.dart';

@immutable
class ChangeCredentialData {
  final String currentPassword;
  final String accessToken;
  final String newEmail;
  final String newPassword;

  const ChangeCredentialData({
    this.currentPassword = '',
    this.accessToken = '',
    this.newEmail = '',
    this.newPassword ='',
  });

  ChangeCredentialData copyWith({
    String? currentPassword,
    String? accessToken,
    String? newEmail,
    String? newPassword,
  }) {
    return ChangeCredentialData(
      currentPassword: currentPassword ?? this.currentPassword,
      accessToken: accessToken ?? this.accessToken,
      newEmail: newEmail ?? this.newEmail,
      newPassword: newPassword ?? this.newPassword,

    );
  }
}