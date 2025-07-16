import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../feature/authentication/data/datasource/auth_local_datasource.dart';
import '../../feature/authentication/data/datasource/auth_remote_datasource.dart';
import '../../feature/authentication/data/datasource/auth_remote_datasource_impl.dart';
import '../../feature/authentication/data/repository_impl/auth_repository_impl.dart';
import '../../feature/authentication/domain/repository/AuthRepository.dart';
import '../../feature/authentication/domain/usecase/login_usecase.dart';
import '../../feature/authentication/domain/usecase/register_usecase.dart';

// 더미 데이터
class DIContainer {
  // static final GetIt _getIt = GetIt.instance;
  //
  // static void setup() {
  //   // 외부 패키지 등록
  //   _getIt.registerLazySingleton<http.Client>(() {
  //     final httpClient = HttpClient()
  //       ..badCertificateCallback =
  //           (X509Certificate cert, String host, int port) => true;
  //     return IOClient(httpClient);
  //   });
  //   _getIt.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  //
  //   // Data Sources 등록
  //   _getIt.registerLazySingleton<AuthLocalDataSource>(
  //           () => AuthLocalDataSourceImpl(storage: _getIt<FlutterSecureStorage>()));
  //   _getIt.registerLazySingleton<AuthRemoteDataSource>(
  //       () => AuthRemoteDataSourceImpl(client: _getIt<http.Client>(), source: _getIt<>));
  //
  //   // Repository 등록
  //   _getIt.registerLazySingleton<AuthRepository>(
  //       () => AuthRepositoryImpl(
  //             remoteDataSource: _getIt<AuthRemoteDataSource>(),
  //             localDataSource: _getIt<AuthLocalDataSource>(),
  //           ));
  //
  //   // Use Cases 등록
  //   _getIt.registerLazySingleton<LoginUseCase>(
  //     () => LoginUseCase(_getIt<AuthRepository>()),
  //   );
  //   _getIt.registerLazySingleton<RegisterUseCase>(
  //     () => RegisterUseCase(_getIt<AuthRepository>()),
  //   );
  // }
  //
  // static void reset() {
  //   _getIt.reset();
  // }
}