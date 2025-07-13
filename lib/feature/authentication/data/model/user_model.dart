
import '../../domain/entity/user_entity.dart';

class UserModel extends User {
  UserModel({
    required String id,
    required String email,
    required String username,
  }) : super(id: id, email: email, username: username);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
    );
  }
}
