import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:soulfit_client/feature/authentication/domain/usecase/logout_usecase.dart';
import 'package:soulfit_client/feature/authentication/presentation/riverpod/logout_riverpod.dart';

import '../../feature/authentication/data/datasource/auth_local_datasource.dart';
import '../../feature/authentication/data/datasource/auth_remote_datasource.dart';
import '../../feature/authentication/data/datasource/auth_remote_datasource_impl.dart';
import '../../feature/authentication/data/datasource/fake_remote_datasource.dart';
import '../../feature/authentication/data/repository_impl/auth_repository_impl.dart';
import '../../feature/authentication/domain/repository/AuthRepository.dart';
import '../../feature/authentication/domain/usecase/login_usecase.dart';
import '../../feature/authentication/domain/usecase/register_usecase.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/register_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/register_state.dart';

/// 1. 외부 패키지 Provider
final httpClientProvider = Provider<http.Client>((ref) {
  final httpClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  return IOClient(httpClient);
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

/// 2. DataSource Provider
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  return AuthLocalDataSourceImpl(storage: ref.read(secureStorageProvider));
});


final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  const useFake = false;

  if (useFake) {
    return FakeAuthRemoteDataSource();
  } else {
    return AuthRemoteDataSourceImpl(client: ref.read(httpClientProvider), source: ref.read(authLocalDataSourceProvider));
  }
});

/// 3. Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    localDataSource: ref.read(authLocalDataSourceProvider),
  );
});

/// 4. UseCase Provider
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(ref.read(authRepositoryProvider));
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(ref.read(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<LogoutUsecase>((ref){
  return LogoutUsecase(ref.read(authRepositoryProvider));
});

// Riverpod Provider 정의
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthStateData>((ref) {
  return AuthNotifier(
    loginUseCase: ref.read(loginUseCaseProvider),
  );
});

// Riverpod Provider 정의
final regiserNotifierProvider = StateNotifierProvider<SignUpNotifier, RegisterState>((ref) {
  return SignUpNotifier(
    registerUseCase: ref.read(registerUseCaseProvider),
  );
});

final logoutNotifierProvider =
StateNotifierProvider<LogoutNotifier, AsyncValue<void>>((ref) {
  final usecase = ref.watch(logoutUseCaseProvider);
  return LogoutNotifier(usecase);
});