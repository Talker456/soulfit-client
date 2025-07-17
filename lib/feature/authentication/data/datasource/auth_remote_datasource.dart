import 'package:soulfit_client/feature/authentication/data/model/change_credential_request_dto.dart';
import 'package:soulfit_client/feature/authentication/data/model/register_request_dto.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/signup_data.dart';

import '../model/login_response_dto.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(String email, String password);
  Future<void> register(SignUpRequestDto data);
  Future<void> logout();
  Future<void> changeCredential(ChangeCredentialRequestDto dto);
}