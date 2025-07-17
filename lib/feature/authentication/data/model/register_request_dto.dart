// data/models/sign_up_request_dto.dart
import '../../domain/entity/signup_data.dart';

class SignUpRequestDto {
  final String name;
  final String birthDate;
  final String gender;
  final String email;
  final String verificationCode;
  final String password;

  SignUpRequestDto({
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.verificationCode,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'username': name,
    'birthDate': birthDate,
    'gender': gender,
    'email': email,
    'password': password,
  };

  factory SignUpRequestDto.fromDomain(SignUpData data) {
    return SignUpRequestDto(
      name: data.name,
      birthDate: data.birthDate,
      gender: data.gender,
      email: data.email,
      verificationCode: data.verificationCode,
      password: data.password,
    );
  }
}
