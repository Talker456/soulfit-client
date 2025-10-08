import 'package:dartz/dartz.dart';

import '../../domain/entity/user_album_photo.dart';
import '../../domain/entity/user_main_profile_info.dart';
import '../../domain/entity/user_value_analysis.dart';
import '../../domain/repository/main_profile_repository.dart';
import '../../data/datasource/main_profile_remote_datasource.dart';

class MainProfileRepositoryImpl implements MainProfileRepository {
  final MainProfileRemoteDataSource remote;

  MainProfileRepositoryImpl(this.remote);

  @override
  Future<Either<Exception, UserMainProfileInfo>> getUserMainProfileInfo(String userId) async {
    try {
      final dto = await remote.fetchUserMainProfileInfo(userId);
      return Right(dto.toEntity());
    } catch (e) {
      return Left(Exception('Failed to load profile info: $e'));
    }
  }

  @override
  Future<Either<Exception, List<String>>> getPerceivedByOthersKeywords(String userId) async {
    try {
      final result = await remote.fetchPerceivedByOthersKeywords(userId);
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to load others keywords: $e'));
    }
  }

  @override
  Future<Either<Exception, List<String>>> getAIPredictedKeywords(String userId) async {
    try {
      final result = await remote.fetchAIPredictedKeywords(userId);
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to load AI keywords: $e'));
    }
  }

  @override
  Future<Either<Exception, UserValueAnalysis>> getUserValueAnalysis(String userId) async {
    try {
      final dto = await remote.fetchUserValueAnalysis(userId);
      return Right(dto.toEntity());
    } catch (e) {
      return Left(Exception('Failed to load value analysis: $e'));
    }
  }

  @override
  Future<Either<Exception, List<UserAlbumPhoto>>> getUserAlbumImages(String userId) async {
    try {
      final dtoList = await remote.fetchUserAlbumImages(userId);
      final entityList = dtoList.map((dto) => dto.toEntity()).toList();
      return Right(entityList);
    } catch (e) {
      return Left(Exception('Failed to load album images: $e'));
    }
  }

  @override
  Future<Either<Exception, bool>> canViewDetailedValueAnalysis({
    required String viewerUserId,
    required String targetUserId,
  }) async {
    try {
      final result = await remote.fetchCanViewDetailedValueAnalysis(
        viewerUserId: viewerUserId,
        targetUserId: targetUserId,
      );
      return Right(result);
    } catch (e) {
      return Left(Exception('Failed to check view permission: $e'));
    }
  }
}
