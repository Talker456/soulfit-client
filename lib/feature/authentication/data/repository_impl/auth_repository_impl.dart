import 'package:soulfit_client/feature/authentication/data/model/change_credential_request_dto.dart';
import 'package:soulfit_client/feature/authentication/data/model/register_request_dto.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/change_credential_data.dart';
import 'package:soulfit_client/feature/authentication/domain/entity/signup_data.dart';

import '../../domain/entity/user_entity.dart';
import '../../domain/repository/AuthRepository.dart';
import '../datasource/auth_local_datasource.dart';
import '../datasource/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User> login(String email, String password) async {
    final loginResponse = await remoteDataSource.login(email, password);
    print("[auth repo impl] : login : success, Access Token : "+loginResponse.accessToken);
    print("[auth repo impl] : user logged in : "+loginResponse.email+", "+loginResponse.username);
    await localDataSource.saveTokens(
        loginResponse.accessToken, loginResponse.refreshToken);
    return loginResponse;
  }

  @override
  Future<void> register(SignUpData data) async {
    final dto = SignUpRequestDto.fromDomain(data);

    await remoteDataSource.register(dto);
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
    await localDataSource.deleteTokens();
  }

  @override
  Future<void> changeCredential(ChangeCredentialData data) async {
    final dto = ChangeCredentialRequestDto.fromDomain(data);

    await remoteDataSource.changeCredential(dto);

  }
}