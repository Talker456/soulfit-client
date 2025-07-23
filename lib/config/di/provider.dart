import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:soulfit_client/feature/authentication/domain/usecase/logout_usecase.dart';
import 'package:soulfit_client/feature/authentication/presentation/riverpod/logout_riverpod.dart';
import 'package:soulfit_client/feature/payment/data/datasource/fake_payment_remote_datasouece_impl.dart';

import '../../feature/authentication/data/datasource/auth_local_datasource.dart';
import '../../feature/authentication/data/datasource/auth_remote_datasource.dart';
import '../../feature/authentication/data/datasource/auth_remote_datasource_impl.dart';
import '../../feature/authentication/data/datasource/fake_remote_datasource.dart';
import '../../feature/authentication/data/repository_impl/auth_repository_impl.dart';
import '../../feature/authentication/domain/repository/AuthRepository.dart';
import '../../feature/authentication/domain/usecase/change_credential_usecase.dart';
import '../../feature/authentication/domain/usecase/login_usecase.dart';
import '../../feature/authentication/domain/usecase/register_usecase.dart';
import '../../feature/authentication/presentation/riverpod/change_credential_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/change_credential_state.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/register_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/register_state.dart';
import '../../feature/payment/data/datasource/payment_remote_datasource_impl.dart';
import '../../feature/payment/data/repository_impl/payment_repository_impl.dart';
import '../../feature/payment/domain/repository/payment_repository.dart';
import '../../feature/payment/domain/usecsae/approve_payment_usecase.dart';
import '../../feature/payment/domain/usecsae/create_order_usecase.dart';

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
  const useFake = true;
  const isAVD = false;

  if (useFake) {
    return FakeAuthRemoteDataSource();
  } else {
    return AuthRemoteDataSourceImpl(
        client: ref.read(httpClientProvider),
        source: ref.read(authLocalDataSourceProvider),
        base: isAVD? "10.0.2.2" : "localhost"
    );
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


final credentialNotifierProvider =
StateNotifierProvider<CredentialNotifier, CredentialStateData>((ref) {
  final changeCredentialUseCase = ref.watch(changeCredentialUseCaseProvider);
  return CredentialNotifier(changeCredentialUseCase: changeCredentialUseCase);
});

/// ChangeCredentialUseCase 주입 Provider 예시 (DI 설정에 따라 변경 가능)
final changeCredentialUseCaseProvider = Provider<ChangeCredentialUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return ChangeCredentialUseCase(repository);
});


/// RemoteDataSource
final remoteDataSourceProvider = Provider((ref) {
  final client = ref.watch(httpClientProvider);
  final source = ref.read(authLocalDataSourceProvider);

  // AVD vs Windows
  // final baseUrl = "10.0.2.2";
  final baseUrl = "localhost";
  return PaymentRemoteDataSourceImpl(client: client, baseUrl: baseUrl, source : source);

  // return FakePaymentRemoteDataSourceImpl(client: client);
});

/// Repository
final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  final remote = ref.watch(remoteDataSourceProvider);
  return PaymentRepositoryImpl(remote);
});

/// UseCase: CreateOrder
final createOrderUseCaseProvider = Provider((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return CreateOrderUseCase(repo);
});

/// UseCase: ApprovePayment
final approvePaymentUseCaseProvider = Provider((ref) {
  final repo = ref.watch(paymentRepositoryProvider);
  return ApprovePaymentUseCase(repo);
});