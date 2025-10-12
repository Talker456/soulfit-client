import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_fake_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/datasource/dating_profile_remote_datasource.dart';
import 'package:soulfit_client/feature/dating_profile/data/repository_impl/dating_profile_repository_impl.dart';
import 'package:soulfit_client/feature/dating_profile/domain/repository/dating_profile_repository.dart';
import 'package:soulfit_client/feature/dating_profile/domain/usecase/get_dating_profile_usecase.dart';
import 'package:soulfit_client/feature/dating_profile/ui/state/dating_profile_state.dart';
import 'package:soulfit_client/feature/dating_profile/ui/notifier/dating_profile_notifier.dart';

// 서버 전환 스위치: true면 Remote, false면 Fake
const bool _useRemote = false;

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'https://api.soulfit.app')); // TODO: 환경별 분리
});

final dataSourceProvider = Provider<DatingProfileDataSource>((ref) {
  if (_useRemote) {
    return DatingProfileRemoteDataSource(ref.read(dioProvider));
  }
  return DatingProfileFakeDataSource();
});

final datingProfileRepositoryProvider = Provider<DatingProfileRepository>((
  ref,
) {
  return DatingProfileRepositoryImpl(ref.read(dataSourceProvider));
});

final getDatingProfileUseCaseProvider = Provider<GetDatingProfileUseCase>((
  ref,
) {
  return GetDatingProfileUseCase(ref.read(datingProfileRepositoryProvider));
});

final datingProfileNotifierProvider =
    AutoDisposeNotifierProvider<DatingProfileNotifier, DatingProfileState>(
      DatingProfileNotifier.new,
    );
