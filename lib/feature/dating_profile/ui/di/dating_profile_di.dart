import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/config/di/provider.dart';
import 'dart:developer' as dev;

import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_fake_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_remote_datasource_impl.dart';
import 'package:soulfit_client/feature/dating_profile/data/repository_impl/dating_profile_repository_impl.dart';
import 'package:soulfit_client/feature/dating_profile/domain/repository/dating_profile_repository.dart';
import 'package:soulfit_client/feature/dating_profile/domain/usecase/get_dating_profile_usecase.dart';


final dioProvider = Provider((ref) {
  dev.log('[DI] Dio init', name: 'DatingProfileDI');
  return Dio(
    BaseOptions(
      baseUrl: 'https://api.soulfit.app',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

final dataSourceProvider = Provider<DatingProfileDataSource>((ref) {
  if (USE_FAKE_DATASOURCE) {
    return DatingProfileFakeDataSource();
  } else {
    return DatingProfileRemoteDataSourceImpl(
        client: ref.read(httpClientProvider),
        authLocalDataSource: ref.read(authLocalDataSourceProvider),
        base: BASE_URL
    );
  }
});

final datingProfileRepositoryProvider = Provider<DatingProfileRepository>(
  (ref) => DatingProfileRepositoryImpl(ref.watch(dataSourceProvider)),
);

final getDatingProfileUseCaseProvider = Provider<GetDatingProfileUseCase>(
  (ref) => GetDatingProfileUseCase(ref.watch(datingProfileRepositoryProvider)),
);
