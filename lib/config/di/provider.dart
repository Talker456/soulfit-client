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
import '../../feature/authentication/domain/usecase/change_credential_usecase.dart';
import '../../feature/authentication/domain/usecase/login_usecase.dart';
import '../../feature/authentication/domain/usecase/register_usecase.dart';
import '../../feature/authentication/presentation/riverpod/change_credential_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/change_credential_state.dart';
import '../../feature/authentication/presentation/riverpod/login_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/register_riverpod.dart';
import '../../feature/authentication/presentation/riverpod/register_state.dart';
import '../../feature/notification/data/datasource/fake_noti_remote_datasource_impl.dart';
import '../../feature/notification/data/datasource/noti_remote_datasource.dart';
import '../../feature/notification/data/repository_impl/notification_repository_impl.dart';
import '../../feature/notification/domain/repository/notification_repository.dart';
import '../../feature/notification/domain/usecase/delete_noti_usecase.dart';
import '../../feature/notification/domain/usecase/get_noti_usecase.dart';
import '../../feature/notification/domain/usecase/mark_all_noti_as_read_usecase.dart';
import '../../feature/notification/domain/usecase/mark_noti_as_read_usecase.dart';
import '../../feature/notification/presentation/riverpod/notification_notifier.dart';
import '../../feature/notification/presentation/riverpod/notification_state_data.dart';
import '../../feature/payment/data/datasource/payment_remote_datasource_impl.dart';
import '../../feature/payment/data/repository_impl/payment_repository_impl.dart';
import '../../feature/payment/domain/repository/payment_repository.dart';
import '../../feature/payment/domain/usecsae/approve_payment_usecase.dart';
import '../../feature/payment/domain/usecsae/create_order_usecase.dart';
// import '../../../feature/coupon/data/datasources/coupon_remote_datasource_impl.dart';  // 실제 API로 변경 시 주석 해제
import '../../../feature/coupon/data/repository_impl/coupon_repository_impl.dart';
import '../../../feature/coupon/domain/repositories/coupon_repository.dart';
import '../../../feature/coupon/domain/usecases/get_coupon_list_usecase.dart';
import '../../../feature/coupon/domain/usecases/register_coupon_usecase.dart';
import '../../../feature/coupon/data/datasources/fake_coupon_remote_datasource.dart';

/// 1. 외부 패키지 Provider
final httpClientProvider = Provider<http.Client>((ref) {
  final httpClient =
      HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
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
      base: isAVD ? "10.0.2.2" : "localhost",
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

final logoutUseCaseProvider = Provider<LogoutUsecase>((ref) {
  return LogoutUsecase(ref.read(authRepositoryProvider));
});

// Riverpod Provider 정의
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthStateData>(
  (ref) {
    return AuthNotifier(loginUseCase: ref.read(loginUseCaseProvider));
  },
);

// Riverpod Provider 정의
final regiserNotifierProvider =
    StateNotifierProvider<SignUpNotifier, RegisterState>((ref) {
      return SignUpNotifier(registerUseCase: ref.read(registerUseCaseProvider));
    });

final logoutNotifierProvider =
    StateNotifierProvider<LogoutNotifier, AsyncValue<void>>((ref) {
      final usecase = ref.watch(logoutUseCaseProvider);
      return LogoutNotifier(usecase);
    });

final credentialNotifierProvider = StateNotifierProvider<
  CredentialNotifier,
  CredentialStateData
>((ref) {
  final changeCredentialUseCase = ref.watch(changeCredentialUseCaseProvider);
  return CredentialNotifier(changeCredentialUseCase: changeCredentialUseCase);
});

/// ChangeCredentialUseCase 주입 Provider 예시 (DI 설정에 따라 변경 가능)
final changeCredentialUseCaseProvider = Provider<ChangeCredentialUseCase>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);
  return ChangeCredentialUseCase(repository);
});

/// RemoteDataSource
final remoteDataSourceProvider = Provider((ref) {
  final client = ref.watch(httpClientProvider);
  final source = ref.read(authLocalDataSourceProvider);

  // AVD vs Windows
  final baseUrl = "10.0.2.2";
  // final baseUrl = "localhost";
  return PaymentRemoteDataSourceImpl(
    client: client,
    baseUrl: baseUrl,
    source: source,
  );

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

final notificationRemoteDataSourceProvider =
    Provider<NotificationRemoteDataSource>((ref) {
      // 실제 서버 연동 구현체
      // return NotificationRemoteDataSourceImpl(
      //   client: ref.read(httpClientProvider),
      //   source: ref.read(authLocalDataSourceProvider),
      //   base: "localhost",
      // base: "10.0.2.2",
      // );

      // 현재는 Fake 사용
      return FakeNotificationRemoteDataSourceImpl();
    });

final notificationRepositoryProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepositoryImpl(
    ref.read(notificationRemoteDataSourceProvider),
  );
});

final getNotificationsUseCaseProvider = Provider<GetNotificationsUseCase>((
  ref,
) {
  return GetNotificationsUseCase(ref.read(notificationRepositoryProvider));
});

final markNotificationAsReadUseCaseProvider =
    Provider<MarkNotificationAsReadUseCase>((ref) {
      return MarkNotificationAsReadUseCase(
        ref.read(notificationRepositoryProvider),
      );
    });

final markAllNotificationsAsReadUseCaseProvider =
    Provider<MarkAllNotificationsAsReadUseCase>((ref) {
      return MarkAllNotificationsAsReadUseCase(
        ref.read(notificationRepositoryProvider),
      );
    });

final deleteNotificationUseCaseProvider = Provider<DeleteNotificationUseCase>((
  ref,
) {
  return DeleteNotificationUseCase(ref.read(notificationRepositoryProvider));
});

final notificationNotifierProvider =
    StateNotifierProvider<NotificationNotifier, NotificationStateData>((ref) {
      return NotificationNotifier(
        getNotificationsUseCase: ref.read(getNotificationsUseCaseProvider),
        markAsReadUseCase: ref.read(markNotificationAsReadUseCaseProvider),
        markAllAsReadUseCase: ref.read(
          markAllNotificationsAsReadUseCaseProvider,
        ),
        deleteUseCase: ref.read(deleteNotificationUseCaseProvider),
      );
    });

// Coupon Repository
final couponRepositoryProvider = Provider<CouponRepository>((ref) {
  return CouponRepositoryImpl(remoteDatasource: FakeCouponRemoteDatasource());
});

// Coupon UseCases
final getAvailableCouponsUseCaseProvider = Provider<GetAvailableCouponsUseCase>(
  (ref) {
    final repository = ref.watch(couponRepositoryProvider);
    return GetAvailableCouponsUseCase(repository);
  },
);

final registerCouponUseCaseProvider = Provider<RegisterCouponUseCase>((ref) {
  final repository = ref.watch(couponRepositoryProvider);
  return RegisterCouponUseCase(repository);
});
