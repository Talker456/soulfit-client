import 'package:flutter/foundation.dart';

/// Represents the data collected during the sign-up process.
@immutable
class SignUpData {
  final String name;
  final String birthDate;
  final String gender;
  final String email;
  final String verificationCode;
  final String password;

  const SignUpData({
    this.name = '',
    this.birthDate = '',
    this.gender = '',
    this.email = '',
    this.verificationCode = '',
    this.password = '',
  });

  SignUpData copyWith({
    String? name,
    String? birthDate,
    String? gender,
    String? email,
    String? verificationCode,
    String? password,
  }) {
    return SignUpData(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      verificationCode: verificationCode ?? this.verificationCode,
      password: password ?? this.password,
    );
  }
}
