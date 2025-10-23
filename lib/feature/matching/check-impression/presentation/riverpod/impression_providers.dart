import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/impression_remote_ds.dart';
import '../../data/repository_impl/impression_repository_impl.dart';
import '../../domain/repositories/impression_repository.dart';
import '../../domain/usecases/get_impression_result.dart';
import '../../domain/entities/impression_result.dart';

final _dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: 'https://mock.api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

final impressionRemoteProvider = Provider(
  (ref) => ImpressionRemoteDataSource(ref.watch(_dioProvider)),
);

final impressionRepoProvider = Provider<ImpressionRepository>(
  (ref) => ImpressionRepositoryImpl(ref.watch(impressionRemoteProvider)),
);

final getImpressionResultProvider = Provider(
  (ref) => GetImpressionResult(ref.watch(impressionRepoProvider)),
);

final impressionResultProvider =
    FutureProvider.family<ImpressionResult, String>((ref, userId) async {
      final usecase = ref.watch(getImpressionResultProvider);
      return usecase(userId);
    });
