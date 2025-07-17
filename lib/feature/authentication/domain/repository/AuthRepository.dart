import 'package:soulfit_client/feature/authentication/data/model/register_request_dto.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/change_credential_data.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/signup_data.dart';

import '../entity/user_entity.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<void> register(SignUpData data);
  Future<void> logout();
  Future<void> changeCredential(ChangeCredentialData data);
}