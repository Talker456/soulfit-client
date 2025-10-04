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
import '../../feature/notification/data/datasource/noti_remote_datasource_impl.dart';
import '../../feature/notification/data/repository_impl/notification_repository_impl.dart';
import '../../feature/notification/domain/repository/notification_repository.dart';
import '../../feature/notification/domain/usecase/delete_noti_usecase.dart';
import '../../feature/notification/domain/usecase/get_noti_usecase.dart';
import '../../feature/notification/domain/usecase/mark_all_noti_as_read_usecase.dart';
import '../../feature/notification/domain/usecase/mark_noti_as_read_usecase.dart';
import '../../feature/notification/presentation/riverpod/notification_notifier.dart';
import '../../feature/notification/presentation/riverpod/notification_state_data.dart';
import '../../feature/payment/data/datasource/fake_payment_remote_datasouece_impl.dart';
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
import '../../feature/matching/filter/data/datasources/filter_remote_datasource.dart';
import '../../feature/matching/filter/data/datasources/filter_remote_datasource_impl.dart';
import '../../feature/matching/filter/data/datasources/fake_filter_remote_datasource.dart';
import '../../feature/matching/filter/data/datasources/filter_local_datasource.dart';
import '../../feature/matching/filter/data/datasources/filter_local_datasource_impl.dart';
import '../../feature/matching/filter/data/repository_impl/filter_repository_impl.dart';
import '../../feature/matching/filter/domain/repositories/filter_repository.dart';
import '../../feature/matching/filter/domain/usecases/get_filtered_users_usecase.dart';
import '../../feature/matching/filter/domain/usecases/save_filter_usecase.dart';
import '../../feature/matching/filter/domain/usecases/get_saved_filter_usecase.dart';
import '../../feature/matching/filter/domain/usecases/clear_saved_filter_usecase.dart';

const bool USE_FAKE_DATASOURCE = true;

const bool _IS_AVD = false; // Android Virtual Device 사용 시 true로 변경
const String BASE_URL = _IS_AVD ? "10.0.2.2" : "localhost";

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
  if (USE_FAKE_DATASOURCE) {
    return FakeAuthRemoteDataSource();
  } else {
    return AuthRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      source: ref.read(authLocalDataSourceProvider),
      base: BASE_URL
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

  if(USE_FAKE_DATASOURCE){
    return FakePaymentRemoteDataSourceImpl(client: client);
  }else{
    return PaymentRemoteDataSourceImpl(
      client: client,
      baseUrl: BASE_URL,
      source: source,
    );
  }
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

      if(USE_FAKE_DATASOURCE){
        return FakeNotificationRemoteDataSourceImpl();
      }else{
        return NotificationRemoteDataSourceImpl(
              client: ref.read(httpClientProvider),
              source: ref.read(authLocalDataSourceProvider),
              base: BASE_URL,
            );
      }
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

// Filter Providers
final filterRemoteDataSourceProvider = Provider<FilterRemoteDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return FakeFilterRemoteDataSource();
  } else {
    return FilterRemoteDataSourceImpl(
      client: ref.read(httpClientProvider),
      authSource: ref.read(authLocalDataSourceProvider),
      baseUrl: BASE_URL,
    );
  }
});

final filterLocalDataSourceProvider = Provider<FilterLocalDataSource>((ref) {
  return FilterLocalDataSourceImpl(
    storage: ref.read(secureStorageProvider),
  );
});

final filterRepositoryProvider = Provider<FilterRepository>((ref) {
  final remoteDataSource = ref.watch(filterRemoteDataSourceProvider);
  final localDataSource = ref.watch(filterLocalDataSourceProvider);
  return FilterRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});

final getFilteredUsersUseCaseProvider = Provider<GetFilteredUsersUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return GetFilteredUsersUseCase(repository);
});

final saveFilterUseCaseProvider = Provider<SaveFilterUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return SaveFilterUseCase(repository);
});

final getSavedFilterUseCaseProvider = Provider<GetSavedFilterUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return GetSavedFilterUseCase(repository);
});

final clearSavedFilterUseCaseProvider = Provider<ClearSavedFilterUseCase>((ref) {
  final repository = ref.watch(filterRepositoryProvider);
  return ClearSavedFilterUseCase(repository);
});
