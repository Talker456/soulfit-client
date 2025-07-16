import 'dart:async';
import 'dart:developer';

import '../../domain/entity/user_entity.dart';
import '../model/login_response_dto.dart';
import '../model/register_request_dto.dart';
import 'auth_remote_datasource.dart';

/// 서버 없이 테스트 가능 하도록 Remote Data source 모방
class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<LoginResponseModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    // 간단한 테스트용 조건
    if (email == 'test@example.com' && password == 'password') {
      return LoginResponseModel(
        id: "1",
        email: "testman@example.com",
        username: "man",
        accessToken: 'fake-access-token',
        refreshToken: 'fake-refresh-token',
        tokenType: "Bearer",
      );
    } else {
      throw Exception('로그인 실패: 이메일 또는 비밀번호가 올바르지 않습니다.');
    }
  }

  @override
  Future<void> register(SignUpRequestDto dto) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network delay

    // 콘솔 출력으로 확인
    log('Fake register called with: ${dto.toJson()}');

    // 테스트용 로직
    if (dto.email.endsWith('@example.com')) {
      return;
    } else {
      throw Exception('회원가입 실패: 유효하지 않은 이메일 형식입니다.');
    }
  }

  @override
  Future<void> logout() async{
    await Future.delayed(const Duration(seconds: 1));

    log('logout on fake remote repo impl');
  }
}
