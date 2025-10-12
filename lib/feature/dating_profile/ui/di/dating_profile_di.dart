import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as dev;

import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_fake_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_remote_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/repository_impl/dating_profile_repository_impl.dart';
import 'package:soulfit_client/feature/dating_profile/domain/repository/dating_profile_repository.dart';
import 'package:soulfit_client/feature/dating_profile/domain/usecase/get_dating_profile_usecase.dart';

const kUseRemote = false;

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
  dev.log('[DI] useRemote=$kUseRemote', name: 'DatingProfileDI');
  if (kUseRemote) {
    dev.log('[DI] Using RemoteDataSource', name: 'DatingProfileDI');
    return DatingProfileRemoteDataSource(ref.watch(dioProvider));
  } else {
    dev.log('[DI] Using FakeDataSource', name: 'DatingProfileDI');
    return DatingProfileFakeDataSource();
  }
});

final datingProfileRepositoryProvider = Provider<DatingProfileRepository>(
  (ref) => DatingProfileRepositoryImpl(ref.watch(dataSourceProvider)),
);

final getDatingProfileUseCaseProvider = Provider<GetDatingProfileUseCase>(
  (ref) => GetDatingProfileUseCase(ref.watch(datingProfileRepositoryProvider)),
);
