import '../../domain/entity/user_entity.dart';

class LoginResponseModel extends User {
  final String accessToken;
  final String refreshToken;
  final String tokenType;

  LoginResponseModel({
    required String id,
    required String email,
    required String username,
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  }) : super(id: id, email: email, username: username);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['id'].toString() ?? '', // Assuming 'id' might not be directly in the response, or needs to be derived
      email: json['email'] ?? '', // Assuming 'email' might not be directly in the response, or needs to be derived
      username: json['username'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      tokenType: json['tokenType'],
    );
  }
}