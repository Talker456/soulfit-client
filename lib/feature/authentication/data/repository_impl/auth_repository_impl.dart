import 'package:soulfit_client/feature/authentication/data/model/register_request_dto.dart';
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
    print("login : success, Access Token : "+loginResponse.accessToken);
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
    await localDataSource.deleteTokens();
  }
}