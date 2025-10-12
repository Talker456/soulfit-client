import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/impression_remote_ds.dart';
import '../../data/repository_impl/impression_repository_impl.dart';
import '../../domain/repositories/impression_repository.dart';
import '../../domain/usecases/submit_impression_feedback.dart';
import 'impression_write_notifier.dart';

const _base = String.fromEnvironment(
  'API_BASE',
  defaultValue: 'https://mock.api',
);

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: _base,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
});

final impressionRemoteProvider = Provider(
  (ref) => ImpressionRemoteDataSource(ref.watch(dioProvider)),
);

final impressionRepoProvider = Provider<ImpressionRepository>(
  (ref) => ImpressionRepositoryImpl(ref.watch(impressionRemoteProvider)),
);

final submitImpressionFeedbackProvider = Provider(
  (ref) => SubmitImpressionFeedback(ref.watch(impressionRepoProvider)),
);

final impressionWriteProvider = StateNotifierProvider.autoDispose
    .family<ImpressionWriteNotifier, ImpressionWriteState, String?>((
      ref,
      targetUserId,
    ) {
      final submit = ref.watch(submitImpressionFeedbackProvider);
      return ImpressionWriteNotifier(submit, targetUserId: targetUserId);
    });
